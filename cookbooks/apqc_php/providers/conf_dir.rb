def load_current_resource
  new_resource.sapi new_resource.name unless new_resource.sapi
end

action :create do
  new_conf_d = ::File.join(node['apqc_php']['conf_dir'],
                           new_resource.sapi,
                           'conf.d')
  link new_conf_d do
    action :delete
    only_if { ::File.symlink?(new_conf_d) }
  end

  d = directory new_conf_d do
    mode '0755'
    owner 'root'
  end
  # Register the sapi so we can build modules.
  file "/usr/share/php5/sapi/#{new_resource.sapi}" do
    action :create
  end

  # detect old versions of ubuntu and translate default extension list.
  global_conf = ::File.join node['apqc_php']['conf_dir'], 'conf.d'
  if ::File.exist? global_conf
    Dir[::File.join(global_conf, '*')].each do |file|
      link ::File.join node['apqc_php']['conf_dir'],
                       new_resource.sapi,
                       'conf.d',
                       ::File.basename(file) do
        to file
      end
    end
  end
  new_resource.updated_by_last_action(d.updated_by_last_action?)
end

action :delete do
  new_conf_d = ::File.join(node['apqc_php']['conf_dir'],
                           new_resource.sapi,
                           'conf.d')
  if ::File.exist?(new_conf_d)
    directory new_conf_d do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end
