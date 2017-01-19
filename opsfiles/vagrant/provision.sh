#!/bin/bash

set -x

apt_install_ansible()
{
  ### input grub-pc setting
  echo "set grub-pc/install_devices /dev/sda" | debconf-communicate

  ### update ubuntu
  apt-get install -f

  ### install ansible
  # 'vivid is Ubuntu 15.4', 'wily is 15.10', 'xenial is 16.04'
  CODENAME='xenial'
  apt install -y software-properties-common
  apt-add-repository ppa:ansible/ansible
  apt update
  apt install -y ansible
}

### install ansible
apt_install_ansible

### ansible-playbook 
playbook_dir='/develop/rancher-dev/opsfiles/vagrant/playbook'
ansible-playbook        -i ${playbook_dir}/vagrant ${playbook_dir}/webservers.yml
