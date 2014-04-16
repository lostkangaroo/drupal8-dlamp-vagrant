# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.network "private_network", ip: "10.0.0.10"
  config.vm.network "forwarded_port", guest:80, host:8080
  config.vm.network "forwarded_port", guest:3306, host:3306

  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/vagrant", :type => "nfs"

  config.vm.provider "virtualbox" do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.name = "#{ENV['SITE_ALIAS']}"
    vb.memory = 2048
    vb.cpus = 2
  end
end
