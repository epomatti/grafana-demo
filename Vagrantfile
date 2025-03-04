# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.provider :virtualbox do |vm|
    vm.cpus = 2
    vm.memory = 2048
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    apt update && apt upgrade -y
	  apt install -y software-properties-common
	  add-apt-repository --yes --update ppa:ansible/ansible
	  apt install -y ansible
    SHELL
end
