#cloud-config

# The top level settings are used as module
# and system configuration.

# Update the contents of /etc/hosts. This will use the name you
# specified when creating the VM in proxmox
manage_etc_hosts: true

system_info:
  distro: debian
  # default_user:
  #   name: debian
  #   gecos: Debian
  #   groups: [adm, audio, cdrom, dialout, dip, floppy, netdev, plugdev, sudo, video]
  #   sudo: ["ALL=(ALL) NOPASSWD:ALL"]
  #   shell: /bin/bash
  #   # add keys here for default user if desired
  #   ssh_authorized_keys:

# users:
#    - default

user:
  name: ${ci_username}
  gecos: kubernetes user creating persistent volumes
  // sudo: "ALL=(ALL) NOPASSWD:ALL"
  shell: /bin/bash
  ssh_authorized_keys:
  - ${ci_pubkey}

disable_root: true
chpasswd:
  list: |
    root:RANDOM

# Update apt database on first boot (run 'apt-get update')
apt_update: true

# Upgrade the instance on first boot
apt_upgrade: true

# Reboot after package install/update if necessary
apt_reboot_if_required: true

# Install useful packages
packages:
- vim
- apt-transport-https
- nfs-kernel-server
- portmap

# Create kubernetes persistent volume NFS directory 
runcmd:
- [mkdir, -p, ${nfs_export_path}]
- [chown, 1000, ${nfs_export_path}]
- echo "${nfs_export_path} ${nfs_export_string}(rw,subtree_check,root_squash,anonuid-1000,anongid=1000)" >> /etc/exports
- [systemctl, enable, nfs-kernel-server]
- [systemctl, restart, nfs-kernel-server]

# Write out new SSH daemon configuration. Standard debian 11 configuration
# apart from forbidding root login and disabling password authentication
write_files:
- path: /etc/ssh/sshd_config
  content: |
    PermitRootLogin no
    PubkeyAuthentication yes
    PasswordAuthentication no
    PermitEmptyPasswords no
    ChallengeResponseAuthentication no
    UsePAM yes
    X11Forwarding yes
    PrintMotd no
    AcceptEnv LANG LC_*
    Subsystem	sftp	/usr/lib/openssh/sftp-server

# The modules that run in the 'init' stage
cloud_init_modules:
 - seed_random
 - write-files
 - set_hostname
 - update_hostname
 - update_etc_hosts
 - ca-certs
 - users-groups
 - ssh

# The modules that run in the 'config' stage
cloud_config_modules:
 - set-passwords
 - ntp
 - timezone
 - disable-ec2-metadata
 - growpart
 - runcmd

# The modules that run in the 'final' stage
cloud_final_modules:
 - package-update-upgrade-install
 - scripts-vendor
 - scripts-per-once
 - scripts-per-boot
 - scripts-per-instance
 - scripts-user
 - ssh-authkey-fingerprints
 - final-message
