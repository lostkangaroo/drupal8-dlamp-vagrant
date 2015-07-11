#
# Cookbook Name:: apqc_php
# Recipe:: module_uuid
#
# Copyright (C) 2015 APQC
#
# All rights reserved - Do Not Redistribute
#

package 'uuid-dev' do
  action :install
end

apqc_php_pecl_extension 'uuid'
