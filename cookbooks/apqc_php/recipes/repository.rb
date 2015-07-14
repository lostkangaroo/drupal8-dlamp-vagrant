#
# Use sury PPA for different versions of PHP.
#
# https://deb.sury.org/
#
# Cookbook Name:: apqc_php
# Recipe:: repository
#
# Copyright (C) 2015 APQC
#

case node['apqc_php']['php_version']
when '5.6'
  ppa_name = 'php5-5.6'
when '5.5'
  ppa_name = 'php5'
when '5.4'
  ppa_name = 'php5-oldstable'
else
  ppa_name = 'php5-oldstable'
end

# Newer PHP repository.
apt_repository 'ondrej-php5' do
  uri "http://ppa.launchpad.net/ondrej/#{ppa_name}/ubuntu"
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'E5267A6C'
end

case node['platform_version']
when '12.04'
  node.default['apqc_php']['ext_dir'] = '/usr/lib/php5/20100525'
end
