#
# Cookbook Name:: apqc_php
# Recipe:: module_yaml
#
# Copyright (C) 2015 APQC
#
# All rights reserved - Do Not Redistribute
#

package 'libyaml-dev' do
  action :install
end

apqc_php_pecl_extension 'yaml'
