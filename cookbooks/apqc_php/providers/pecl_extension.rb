include Chef::DSL::IncludeRecipe

def load_current_resource
  #
end

action :create do
  # ensure pecl packages are installed.
  include_recipe 'apqc_php::pecl'

  extension_dir = node['apqc_php']['ext_dir']
  t = template ::File.join(node['apqc_php']['ext_conf_dir'], "#{new_resource.name}.ini") do
    source 'pecl.ini.erb'
    cookbook 'apqc_php'
    mode 0644
    variables(
      name: new_resource.name,
      settings: new_resource.settings
    )
  end

  execute "pecl-install#{new_resource.name}" do
    command "pecl install #{new_resource.name}"
    creates "#{extension_dir}/#{new_resource.name}.so"
    action :run
  end

  execute "php5enmod-#{new_resource.name}" do
    command "php5enmod #{new_resource.sapi} #{new_resource.name}"
    # creates '/tmp/something'
    action :run
  end

  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

action :delete do
  if ::File.exist?(::File.join(node['apqc_php']['ext_conf_dir'], "#{new_resource.name}.ini"))
    file ::File.join(node['apqc_php']['ext_conf_dir'], "#{new_resource.name}.ini") do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end
