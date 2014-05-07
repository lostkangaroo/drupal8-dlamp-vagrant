# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!

ENV['SITE_ALIAS'] = "dev.local" if ENV['SITE_ALIAS'].to_s.empty?

# Do all the things
Vagrant.configure("2") do |config|

  # create a box based on the site alias
  config.vm.define "#{ENV['SITE_ALIAS']}" do |web|
    # Every Vagrant virtual environment requires a box to build off of.
    web.vm.box = "Precise64"
    web.vm.box_url = "http://files.vagrantup.com/precise64.box"
    web.vm.box_check_update = true

    # Configure network fun
    web.vm.network "private_network", ip: "10.0.0.10"
    web.vm.network "forwarded_port", guest: 80, host: 8080
    web.vm.network "forwarded_port", guest: 3306, host: 3306
    web.ssh.forward_agent = true

    # Use environment variables set in phpstorm to sync project files
    if (!ENV['PROJECTS_DIR'].to_s.empty?)
      web.vm.synced_folder "#{ENV['PROJECTS_DIR']}#{ENV['SITE_ALIAS']}", "/vagrant/public/#{ENV['SITE_ALIAS']}", type: "nfs"
    end

    # Set VirtualBox settings
    web.vm.provider "virtualbox" do |vb|
      vb.name = "#{ENV['SITE_ALIAS']}"
      vb.memory = "4096"
      vb.cpus = "2"
    end

    # Ensure latest version of chef is available
    # requires omnibus plugin for vagrant
    web.omnibus.chef_version = :latest

    # Enable provisioning with chef solo
    web.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = "cookbooks"

      chef.add_recipe "dlamp"

      chef.json = {
        :vhost => {
          :www_root => "/vagrant/public/#{ENV['SITE_ALIAS']}",
          :localhost_alias => "#{ENV['SITE_ALIAS']}"
        }
      }
    end
  end
end
