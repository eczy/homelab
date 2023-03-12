module "first_control_plane_node" {
  source = "../../modules/proxmox/kubernetes/control-plane"

  proxmox_target_node = var.proxmox_target_node

  vm_name       = "${var.cluster_name}-cp-first"
  clone_vm_name = var.control_plane_nodes.clone_vm_name
  networks      = var.control_plane_nodes.networks
  disks         = var.control_plane_nodes.disks
  bootdisk      = var.control_plane_nodes.bootdisk

  cores   = var.control_plane_nodes.cores
  sockets = var.control_plane_nodes.sockets
  memory  = var.control_plane_nodes.memory

  first              = true
  upload_certs       = var.control_plane_nodes.count > 1
  kubeadm_token      = var.kubeadm_token
  kubeadm_cert       = var.kubeadm_cert
  kube_proxy_arch    = var.kube_proxy_arch
  kube_proxy_version = var.kube_proxy_version

  control_plane_endpoint = var.control_plane_endpoint
  pod_network_cidr       = var.pod_network_cidr
  username               = var.username
  private_key_file       = var.private_key_file
}

module "additional_control_plane_nodes" {
  source = "../../modules/proxmox/kubernetes/control-plane"
  count  = var.control_plane_nodes.count - 1

  proxmox_target_node = var.proxmox_target_node
  vm_name             = "${var.cluster_name}-cp-add-${count.index}"
  clone_vm_name       = var.control_plane_nodes.clone_vm_name
  networks            = var.control_plane_nodes.networks
  disks               = var.control_plane_nodes.disks
  bootdisk            = var.control_plane_nodes.bootdisk

  cores   = var.control_plane_nodes.cores
  sockets = var.control_plane_nodes.sockets
  memory  = var.control_plane_nodes.memory

  first                  = false
  kubeadm_token          = var.kubeadm_token
  kubeadm_cert           = var.kubeadm_cert
  kube_proxy_arch        = var.kube_proxy_arch
  kube_proxy_version     = var.kube_proxy_version
  control_plane_endpoint = var.control_plane_endpoint
  pod_network_cidr       = var.pod_network_cidr

  username         = var.username
  private_key_file = var.private_key_file


  depends_on = [
    module.first_control_plane_node
  ]
}

module "worker_nodes" {
  source = "../../modules/proxmox/kubernetes/worker"
  count  = var.worker_nodes.count

  proxmox_target_node = var.proxmox_target_node

  vm_name       = "${var.cluster_name}-worker-${count.index}"
  clone_vm_name = var.worker_nodes.clone_vm_name
  networks      = var.worker_nodes.networks
  disks         = var.worker_nodes.disks
  bootdisk      = var.worker_nodes.bootdisk

  cores   = var.worker_nodes.cores
  sockets = var.worker_nodes.sockets
  memory  = var.worker_nodes.memory

  control_plane_endpoint = var.control_plane_endpoint
  kubeadm_token          = var.kubeadm_token

  username         = var.username
  private_key_file = var.private_key_file

  depends_on = [
    module.first_control_plane_node,
    # this dependency might not actually be required, but it seemed
    # to fix some connectivity issues
    # TODO: determine if this can be removed 
    module.additional_control_plane_nodes
  ]
}

module "nfs_servers" {
  source = "../../modules/proxmox/kubernetes/nfs"
  count  = var.nfs_servers.count

  proxmox_target_node = var.proxmox_target_node

  vm_name       = "${var.cluster_name}-nfs-${count.index}"
  clone_vm_name = var.nfs_servers.clone_vm_name
  networks      = var.nfs_servers.networks
  disks         = var.nfs_servers.disks
  bootdisk      = var.nfs_servers.bootdisk

  cores   = var.nfs_servers.cores
  sockets = var.nfs_servers.sockets
  memory  = var.nfs_servers.memory
}