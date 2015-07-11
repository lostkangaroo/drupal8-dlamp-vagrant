#
# Cookbook Name:: apqc_php
# Recipe:: repository
#
# Copyright (C) 2015 APQC
#
# All rights reserved - Do Not Redistribute
#

# Newer PHP repository.
apt_repository 'ondrej-php5' do
  uri 'http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'E5267A6C'
end

case node['platform_version']
when '12.04'
  node.default['apqc_php']['ext_dir'] = '/usr/lib/php5/20100525'
end
