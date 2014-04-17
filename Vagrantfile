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

  # Tell Vagrant where the project files are since PHPStorm allows us to point to vagrantfiles outside of the project
  # root.  Allows for a cleaner project file structure.  Comment this out and use the other option if you would like
  # to use the default.
  config.vm.synced_folder "e:/htdocs/#{ENV['SITE_ALIAS']}", "/vagrant/public/#{ENV['SITE_ALIAS']}", type: "nfs"
  #config.vm.synced_folder ".", "/vagrant", :type => "nfs"

  # Use VBoxManage to customize the VM. For example to change memory:
  config.vm.provider "virtualbox" do |vb|
    vb.name = "#{ENV['SITE_ALIAS']}"
    vb.memory = 2048
    vb.cpus = 2
  end

  # Configure the server using chef-solo
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "apt"
    chef.add_recipe "apache2"
    chef.add_recipe "mysql"
    chef.add_recipe "php"
  end
end
