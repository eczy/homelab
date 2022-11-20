locals {
  control_plane_vip = split(":", var.control_plane_endpoint)[0]
  provision_script_first = [
    # TODO template these as scripts then render -> run instead of this mess
    # TODO these could also probably be abstracted out into the caller
    "set -o errexit",
    # install and configure kube-vip in arp mode
    "sudo ctr images pull ghcr.io/kube-vip/kube-vip:${var.kube_vip_version}",
    "alias kube-vip=\"sudo ctr run --rm --net-host ghcr.io/kube-vip/kube-vip:${var.kube_vip_version} vip /kube-vip\"",
    "kube-vip manifest pod --interface ${var.kube_vip_interface} --address ${local.control_plane_vip} --controlplane --arp --leaderElection | sudo tee /etc/kubernetes/manifests/kube-vip.yaml",

    # upload certs if enabled
    var.upload_certs ?
    "sudo kubeadm init --token ${var.kubeadm_token} --certificate-key ${var.kubeadm_cert} --control-plane-endpoint ${var.control_plane_endpoint} --pod-network-cidr ${var.pod_network_cidr} --upload-certs"
    :
    "sudo kubeadm init --token ${var.kubeadm_token} --control-plane-endpoint ${var.control_plane_endpoint} --pod-network-cidr ${var.pod_network_cidr}",

    # setup user kubectl
    "mkdir -p $HOME/.kube",
    "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config",
    "sudo chown $(id -u):$(id -g) $HOME/.kube/config",

    # setup kuberouter with service proxy
    "kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml",
    "kubectl -n kube-system delete ds kube-proxy",
    "sudo ctr images pull k8s.gcr.io/kube-proxy-${var.kube_proxy_arch}:v${var.kube_proxy_version}",
    "sudo ctr run --rm --privileged --net-host --mount type=bind,src=/lib/modules,dst=/lib/modules,options=rbind:ro k8s.gcr.io/kube-proxy-${var.kube_proxy_arch}:v${var.kube_proxy_version} kube-proxy-cleanup kube-proxy --cleanup",
  ]
  provision_script_additional = [
    "sudo kubeadm join --token ${var.kubeadm_token} --control-plane  --certificate-key ${var.kubeadm_cert} --discovery-token-unsafe-skip-ca-verification ${var.control_plane_endpoint}",

    # generate the same kube-vip config in backup control plane nodes
    "sudo ctr images pull ghcr.io/kube-vip/kube-vip:${var.kube_vip_version}",
    "alias kube-vip=\"sudo ctr run --rm --net-host ghcr.io/kube-vip/kube-vip:${var.kube_vip_version} vip /kube-vip\"",
    "kube-vip manifest pod --interface ${var.kube_vip_interface} --address ${local.control_plane_vip} --controlplane --arp --leaderElection | sudo tee /etc/kubernetes/manifests/kube-vip.yaml",
  ]
  provision_script = var.first ? local.provision_script_first : local.provision_script_additional
}

resource "proxmox_vm_qemu" "node" {
  target_node = var.proxmox_target_node

  name       = var.vm_name
  desc       = "Terraform managed k8s control-plane node. Updated at ${timestamp()}."
  clone      = var.clone_vm_name
  full_clone = true

  dynamic "disk" {
    for_each = var.disks
    content {
      type        = disk.value["type"]
      storage     = disk.value["storage"]
      size        = disk.value["size"]
      format      = disk.value["format"]
      cache       = disk.value["cache"]
      backup      = disk.value["backup"]
      iothread    = disk.value["iothread"]
      replicate   = disk.value["replicate"]
      ssd         = disk.value["ssd"]
      discard     = disk.value["discard"]
      mbps        = disk.value["mbps"]
      mbps_rd     = disk.value["mbps_rd"]
      mbps_rd_max = disk.value["mbps_rd_max"]
      mbps_wr     = disk.value["mbps_wr"]
      mbps_wr_max = disk.value["mbps_wr_max"]
      media       = disk.value["media"]
    }
  }

  dynamic "network" {
    for_each = var.networks
    content {
      model     = network.value["model"]
      macaddr   = network.value["macaddr"]
      bridge    = network.value["bridge"]
      tag       = network.value["tag"]
      firewall  = network.value["firewall"]
      rate      = network.value["rate"]
      queues    = network.value["queues"]
      link_down = network.value["link_down"]
    }
  }

  cores    = var.cores
  sockets  = var.sockets
  memory   = var.memory
  bootdisk = var.bootdisk

  automatic_reboot = true
  onboot           = true

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.username
      private_key = file("${path.root}/${var.private_key_file}")
      host        = var.vm_name
    }

    inline = local.provision_script
  }
}