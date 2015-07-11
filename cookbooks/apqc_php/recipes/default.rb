#
# Cookbook Name:: apqc_php
# Recipe:: default
#
# Copyright (C) 2015 APQC
#
# All rights reserved - Do Not Redistribute
#

# Setup modern debian folders and tools.
directory '/usr/share/php5/sapi/' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

directory '/etc/php5/mods-available' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

cookbook_file '/usr/sbin/php5enmod' do
  source 'php5enmod'
  owner 'root'
  group 'root'
  mode '0755'
end

link '/usr/sbin/php5dismod' do
  to '/usr/sbin/php5enmod'
end

cookbook_file '/usr/share/php5/php5-helper' do
  source 'php5-helper'
  owner 'root'
  group 'root'
  mode '0644'
end

cookbook_file '/usr/sbin/php5query' do
  source 'php5query'
  owner 'root'
  group 'root'
  mode '0755'
end
