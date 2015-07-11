#
# Cookbook Name:: apqc_php
# Recipe:: pecl
#
# Copyright (C) 2015 APQC
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apqc_php::default'

%w(php-pear php5-dev make).each do |pkg|
  package pkg do
    action :install
  end
end
