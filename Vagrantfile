# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "fedora/35-cloud-base"
  config.vm.box_version = "35.20211026.0"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
   end

  # Enable provisioning with a shell script
  config.vm.provision :shell, path: "bootstrap.sh"
end
