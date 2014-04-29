# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
CPUS = 2
MEMORY = 4096

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "Precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.box_check_update = true

  # Configure network fun
  config.vm.network "private_network", ip: "10.0.0.10"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.ssh.forward_agent = true

  # Use environment variables set in phpstorm to sync project files
  config.vm.synced_folder "#{ENV['PROJECTS_DIR']}#{ENV['SITE_ALIAS']}", "/vagrant/public/#{ENV['SITE_ALIAS']}"

  # Allow the Box to be
  config.vm.provider "virtualbox" do |vb|
    vb.name = "#{ENV['SITE_ALIAS']}"
    vb.memory = MEMORY
    vb.cpus = CPUS
  end

  # Ensure latest version of chef is available
  # requires omnibus plugin for vagrant
  config.omnibus.chef_version = :latest

  # Enable provisioning with chef solo
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "cookbooks"

    chef.add_recipe "apt"
    chef.add_recipe "apache2"
    chef.add_recipe "mysql::server"
    chef.add_recipe "apqc_php::php"
    chef.add_recipe "apqc_php::drush"
    chef.add_recipe "vhost"

    chef.json = {
      :vhost => {
        :www_root => "/vagrant/public/#{ENV['SITE_ALIAS']}",
        :localhost_alias => "#{ENV['SITE_ALIAS']}"
      },
      :mysql => {
        :server_root_password => 'root',
        :allow_remote_root => true,
        :bind_address => "0.0.0.0"
      },
      :drush => {
        :install_method => "git",
        :version => "master",
        :install_dir => "/usr/share/drush"
      }
    }
  end
end
