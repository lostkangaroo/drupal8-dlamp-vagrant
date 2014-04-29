#
# Cookbook Name:: apqc_php
# Recipe:: drush
#
# Copyright (C) 2013 APQC
#
# All rights reserved - Do Not Redistribute
#


## Install Drush
# upstream drush recipe calls opscode php recipe which is crap. this shunts the
# php.ini changes its going to make into /tmp so it doesn't interfere with our
# recipe.
node.default['php']['conf_dir'] = '/tmp'

# Ensure pear is installed.
# package "php-pear" do
#   action :install
# end

# node.default['drush']['install_method'] = "git"
# include_recipe "drush::install_console_table"
include_recipe "drush::#{node['drush']['install_method']}"

