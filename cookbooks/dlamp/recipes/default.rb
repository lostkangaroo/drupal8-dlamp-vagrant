#
# Author:: Andrew Jungklaus <lostkangaroo@lostkangaroo.net>
# Cookbook Name:: dlamp
# Recipe:: default
# Description:: Sets a runlist and default values to use in building a Drupal 8
#   Development Environment
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Default Values to use

# MySQL
node.default['mysql']['server_root_password'] = 'root'
node.default['mysql']['allow_remote_root'] = true
node.default['mysql']['bind_address'] = "0.0.0.0"

# Drush
node.default['drush']['install_method'] = "git"
node.default['drush']['version'] = "master"
node.default['drush']['install_dir'] = "/usr/share/drush"

# XDebug
node.default['xdebug']['remote_enable'] = 1
node.default['xdebug']['remote_connect_back'] = 1
node.default['xdebug']['version'] = "latest"

# Composer
node.default['composer']['php_recipe'] = "apqc_php::php"

# vhost
node.default['vhost']['allow_override'] = "ALL"

# Recipe Run List
include_recipe "apt"
include_recipe "apache2"
include_recipe "mysql::server"
include_recipe 'apqc_php::php'
include_recipe "apqc_php::drush"
include_recipe "vhost"
include_recipe "xdebug"
include_recipe "phpunit"
