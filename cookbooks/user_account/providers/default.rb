action :create do
  if add_user_account
    group new_resource.username do
      gid new_resource.uid unless new_resource.uid.nil?
      action :create
      only_if { new_resource.gid.nil? }
    end

    group_id = new_resource.gid.nil? ? new_resource.username : new_resource.gid

    user new_resource.username do
      gid group_id
      home home_dir
      password new_resource.password unless new_resource.password.nil?
      shell new_resource.shell || node['user_account']['default_shell']
      uid new_resource.uid unless new_resource.uid.nil?
      action :create
    end

    directory "#{new_resource.username}_home_dir" do
      path home_dir
      action :create
      mode 0755
      owner new_resource.username
      group group_id
      only_if { new_resource.manage_home }
    end

    unless ssh_keys.nil?
      directory "#{home_dir}/.ssh" do
        action :create
        mode 0700
        owner new_resource.username
        group group_id
      end

      template "#{home_dir}/.ssh/authorized_keys" do
        mode 0600
        owner new_resource.username
        group group_id
        action :create
        source 'authorized_keys.erb'
        cookbook 'user_account'
        variables(keys: ssh_keys)
      end
    end

    unless new_resource.groups.nil?
      case node['platform_family']
      when 'debian', 'fedora', 'suse', 'rhel'
        new_resource.groups.each do |grp|
          group grp do
            append true
            members new_resource.username
          end
        end
      # Chef doesn't handle groups properly for these systems
      when 'omnios', 'smartos'
        new_resource.groups.each do |grp|
          group grp do
            action :create
          end
        end
        groups = new_resource.groups.push(new_resource.username).join(',')
        execute "add_#{new_resource.username}_to_groups" do
          command "usermod -G #{groups} #{new_resource.username}"
        end
      end
    end
    new_resource.updated_by_last_action true
  else
    new_resource.updated_by_last_action false
  end
end

action :remove do
  usr = user new_resource.username do
    action :nothing
  end
  usr.run_action :remove

  grp = group new_resource.username do
    action :nothing
  end

  directory "#{new_resource.username}_home_dir" do
    path home_dir
    action :delete
    recursive true
    only_if { new_resource.delete_home_dir }
  end

  grp.run_action :remove

  if grp.updated_by_last_action? || usr.updated_by_last_action?
    new_resource.updated_by_last_action true
  else
    new_resource.updated_by_last_action false
  end
end

def ssh_keys
  if new_resource.ssh_keys.kind_of? String
    [new_resource.ssh_keys]
  else
    new_resource.ssh_keys
  end
end

def include_nodes
  if new_resource.include_nodes.kind_of? String
    [new_resource.include_nodes]
  else
    new_resource.include_nodes
  end
end

def exclude_nodes
  if new_resource.exclude_nodes.kind_of? String
    [new_resource.exclude_nodes]
  else
    new_resource.exclude_nodes
  end
end

def home_dir
  if new_resource.home.nil?
    ::File.join(node['user_account']['home_root'],
                new_resource.username)
  else
    new_resource.home
  end
end

def add_user_account
  add_user = true
  unless include_nodes.nil?
    add_user = false unless include_nodes.include? node.name
  end

  unless exclude_nodes.nil?
    add_user = false if exclude_nodes.include? node.name
  end
  add_user
end
