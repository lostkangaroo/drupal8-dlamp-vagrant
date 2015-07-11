#
# Cookbook Name:: apqc_php
# Recipe:: drush
#
# Copyright (C) 2013 APQC
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apqc_php::sapi_cli'

# We need pear and related tools and this will give us that.
include_recipe 'apqc_php::pecl'

## Install Drush
# upstream drush recipe calls opscode php recipe which is crap. this shunts the
# php.ini changes its going to make into /tmp so it doesn't interfere with our
# recipe.
node.default['php']['conf_dir'] = '/tmp'
# Also disable its package list.
node.default['php']['packages'] = {}

# node.default['drush']['install_method'] = "pear"
include_recipe "drush::#{node['drush']['install_method']}"
if node.default['drush']['install_method'] == 'pear'
  include_recipe 'drush::install_console_table'
end
