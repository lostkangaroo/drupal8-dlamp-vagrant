include_recipe "apache2"

web_app "#{node['vhost']['localhost_alias']}" do
  server_name "#{node['vhost']['localhost_alias']}"
  server_aliases "#{node['vhost']['localhost_alias']}"
  docroot "#{node['vhost']['www_root']}"
end