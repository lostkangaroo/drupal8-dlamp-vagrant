#
# Cookbook Name:: apqc_php
# Recipe:: module_yaml
#
# Copyright (C) 2015 APQC
#

package 'libyaml-dev' do
  action :install
end

apqc_php_pecl_extension 'yaml'
