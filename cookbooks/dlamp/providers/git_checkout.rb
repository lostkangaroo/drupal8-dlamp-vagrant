
def load_current_resource
  #
end

action :create do
  # whole sale make sure the destination is writeable
  directory new_resource.destination do
    mode "0777"
  end

  # add the git repo to known hosts so we don't have issues pulling things in
  # ssh_known_hosts repo['fdqn'] do
  #   user "vagrant"
  # end

  if !new_resource.deploy_key.empty?
    # create a ssh key wrapper we can use if a deploy key is needed
    file "/home/vagrant/#{new_resource.name}.git_wrapper.sh" do
      owner "vagrant"
      mode "0755"
      content "#!/bin/sh\nexec /usr/bin/ssh -i /home/vagrant/.ssh/#{new_resource.name}.deploy_rsa \"$@\""
    end

    # create the key itself to be used
    file "/home/vagrant/.ssh/#{new_resource.name}.deploy_rsa" do
      owner "vagrant"
      mode "0600"
      content new_resource.deploy_key
    end

    # add this key to ssh config file
    ssh_config new_resource.fdqn do
      options 'User' => 'git', 'IdentityFile' => "/home/vagrant/.ssh/#{new_resource.name}.deploy_rsa"
    end
  end

  git new_resource.destination do
    repository new_resource.repo
    revision new_resource.revision
    user "vagrant"
    if new_resource.deploy_key
      ssh_wrapper "/home/vagrant/" + new_resource.name + ".git_wrapper.sh"
    end
    action :sync
  end
end

action :delete do
  if ::File.exist?(new_resource.destination)
    file new_resource.destination do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end