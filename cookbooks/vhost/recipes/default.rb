include_recipe "apache2"

Chef::Log.info "Attempting to locate databag vhosts"
if Chef::DataBag.list.key?('vhost')
  begin
    vhosts = data_bag('vhost').collect do |item|
      vhost = data_bag_item('vhost', item)

      node['vhost'] << vhost
    end
  rescue
    Chef::Log.warn "Could not load data bag 'vhost'"
  end
end

node['vhost'].each do |host|
  web_app "#{host['localhost_alias']}" do
    server_name "#{host['localhost_alias']}"
    server_aliases "#{host['localhost_alias']}"
    docroot "#{host['www_root']}"
    allow_override "#{host['allow_override']}"
  end

  hostsfile_entry '127.0.0.1' do
    hostname "#{host['localhost_alias']}"
    action :append
  end
end
