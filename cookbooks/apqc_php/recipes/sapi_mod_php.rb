#
# Cookbook Name:: apqc_php
# Recipe:: mod_php
#
# Copyright (C) 2015 APQC
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apqc_php::default'

# Install mod_php
node.default['apache']['mpm'] = 'prefork'
include_recipe 'apache2::mod_php5'

apqc_php_conf_dir 'apache2'

if node['apqc_php']['ini_files']['apache2']

  if node['apqc_php']['ini_overrides']['apache2']
    ini_settings = Chef::Mixin::DeepMerge.deep_merge(
      node['apqc_php']['ini_defaults'].to_hash,
      node['apqc_php']['ini_overrides']['apache2'].to_hash)
  else
    ini_settings = node['apqc_php']['ini_defaults'].to_hash
  end
  unless node['apqc_php']['directives'].empty?
    ini_settings['Extra'] = node['apqc_php']['directives'].to_hash
  end
  path = File.join(node['apqc_php']['conf_dir'],
                   'apache2',
                   'php.ini')
  apqc_php_php_ini path do
    enable_sections true
    settings ini_settings
  end
end
