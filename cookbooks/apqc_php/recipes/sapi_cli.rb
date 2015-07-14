#
# Cookbook Name:: apqc_php
# Recipe:: cli
#
# Copyright (C) 2015 APQC
#

include_recipe 'apqc_php::default'

package 'php5-cli' do
  action :install
end

apqc_php_conf_dir 'cli'

if node['apqc_php']['ini_files']['cli']

  if node['apqc_php']['ini_overrides']['cli']
    ini_settings = Chef::Mixin::DeepMerge.deep_merge(
      node['apqc_php']['ini_defaults'].to_hash,
      node['apqc_php']['ini_overrides']['cli'].to_hash)
  else
    ini_settings = node['apqc_php']['ini_defaults'].to_hash
  end
  unless node['apqc_php']['directives'].empty?
    ini_settings['Extra'] = node['apqc_php']['directives'].to_hash
  end

  path = File.join(node['apqc_php']['conf_dir'],
                   'cli',
                   'php.ini')
  apqc_php_php_ini path do
    settings ini_settings
  end
end
