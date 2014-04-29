# A hodge podge of the opscode php recipe, a PR from hw-cookbooks and APQC settings.

# Random link to the original website.
# http://info.cern.ch/hypertext/WWW/TheProject.html

# Newer PHP repository.
apt_repository "ondrej-php5" do
  uri "http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "hkp://keyserver.ubuntu.com:80"
  key "E5267A6C"
end

# Install php
include_recipe "apache2::mod_php5"
# and our modules.
%w{php5-cli php5-mysql php5-gd php5-memcache php-apc php5-mcrypt php5-curl}.each do |pkg|
  package pkg do
    action :install
  end
end

# Manage ini files.
node['apqc_php']['php']['ini_files'].each do |ini_key, enabled|
  if(enabled)
    if(node['apqc_php']['php']['ini_overrides'][ini_key])
      ini_settings = Chef::Mixin::DeepMerge.deep_merge(node['apqc_php']['php']['ini_defaults'].to_hash, node['apqc_php']['php']['ini_overrides'][ini_key].to_hash)
    else
      ini_settings = node['apqc_php']['php']['ini_defaults'].to_hash
    end
    unless(node['apqc_php']['php']['directives'].empty?)
      ini_settings['Extra'] = node['apqc_php']['php']['directives'].to_hash
    end
    path = [node['apqc_php']['php']['conf_dir']]
    path << ini_key unless ini_key == 'root'
    path << 'php.ini'
    apqc_php_php_ini path.join('/') do
      enable_sections true
      settings ini_settings
    end
  end
end
