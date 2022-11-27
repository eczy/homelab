# Homelab

DISCLAIMER: Nothing in this repo is meant to be used in production. This is a basic setup meant for use on a private home network and would require SIGNIFICANT hardening before use in any serious capacity (e.g. firewall config, removing remote bases from kustomize files, secret management, proper RBAC config, etc.). DO NOT use this as-is for anything important.

Note: Desired image sizes must be baked into the template generated from the Packer dir due to the images using LVM. Cloud-init resizing is not possible

TODO:
- automation around argo/argocd/argoevents
- promethus + grafana monitoring stack
- documentation for terraform modules
- automated cluster backups
- gitea
- artifact registry
- fill out readmes and terraform descriptions
- automated proxmox environment provisioning
- yaml linting
- combine `kubernetes-cluster` and `kubernetes-bootstrap` root modules (need a way to securely pull down admin config for subsequent use)
- move some of the initial bootstrapping from `kubernetes-bootstrap` to argocd bootstrapping
- automated way of adding nfs storage classes for variable amount of servers (https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)
- move bootstrapping to another repo
- abstract out nfs server into more general module (honestly just make most of these tf abstractions better)
- argocd application terraform module
- pihole dns terraform module