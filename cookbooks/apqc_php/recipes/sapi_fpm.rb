#
# Cookbook Name:: apqc_php
# Recipe:: fpm
#
# Copyright (C) 2015 APQC
#

include_recipe 'apqc_php::default'

package 'php5-fpm' do
  action :install
end

apqc_php_conf_dir 'fpm'

if node['apqc_php']['ini_files']['fpm']

  if node['apqc_php']['ini_overrides']['fpm']
    ini_settings = Chef::Mixin::DeepMerge.deep_merge(
      node['apqc_php']['ini_defaults'].to_hash,
      node['apqc_php']['ini_overrides']['fpm'].to_hash)
  else
    ini_settings = node['apqc_php']['ini_defaults'].to_hash
  end
  unless node['apqc_php']['directives'].empty?
    ini_settings['Extra'] = node['apqc_php']['directives'].to_hash
  end
  path = File.join(node['apqc_php']['conf_dir'],
                   'fpm',
                   'php.ini')
  apqc_php_php_ini path do
    enable_sections true
    settings ini_settings
  end
end
