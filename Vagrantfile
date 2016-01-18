# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!

ENV['SITE_ALIAS'] = "dev.local" if ENV['SITE_ALIAS'].to_s.empty?

# Do all the things
Vagrant.configure("2") do |config|

  # create a box based on the site alias
  config.vm.define "#{ENV['SITE_ALIAS']}" do |web|
    # Every Vagrant virtual environment requires a box to build off of.

    # Use environment variables to set the guest
    if (ENV['VM_PROVIDER'] == 'vmware_workstation')
      # If using vmware-workstation
      web.vm.box = "phusion/ubuntu-14.04-amd64"
      web.vm.box_check_update = true
    else
      # If using virtual box
      web.vm.box = "ubuntu/trusty64"
      web.vm.box_check_update = true
    end

    # Configure network fun
    web.vm.network "private_network", ip: "10.0.0.10"
    web.vm.network "forwarded_port", guest: 80, host: 8080
    web.vm.network "forwarded_port", guest: 3306, host: 3306
    web.ssh.forward_agent = true

    # Use environment variables set in phpstorm to sync project files, nfs is ignored on windows systems
    if (!ENV['PROJECT_DIR'].to_s.empty?)
      web.vm.synced_folder "#{ENV['PROJECT_DIR']}", "/vagrant/public/#{ENV['SITE_ALIAS']}", type: "nfs"
    end

    # Use environment variables to set the guest
    if (ENV['VM_PROVIDER'] == 'vmware_workstation')
      # Set VMware Settings
      web.vm.provider "vmware_workstation" do |vw|
        vw.vmx["name"] = "#{ENV['SITE_ALIAS']}"
        vw.vmx["memsize"] = "4000"
        vw.vmx["numvcpus"] = "2"
      end
    else
      # Set VirtualBox settings
      web.vm.provider "virtualbox" do |vb|
        vb.name = "#{ENV['SITE_ALIAS']}"
        vb.memory = "2000"
        vb.cpus = "2"
      end
    end

    # Ensure latest version of chef is available
    # requires omnibus plugin for vagrant
    web.omnibus.chef_version = :latest

    # Enable provisioning with chef solo
    web.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = "cookbooks"

      chef.add_recipe "dlamp"

      chef.json = {
        :vhost => [
          {
            :www_root => "/vagrant/public/#{ENV['SITE_ALIAS']}",
            :localhost_alias => "#{ENV['SITE_ALIAS']}",
            :allow_override => "ALL"
          }
        ]
      }

      chef.data_bags_path = 'data_bags'
    end
  end
end
