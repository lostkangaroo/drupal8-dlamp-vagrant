#
# Author:: Andrew Jungklaus <lostkangaroo@lostkangaroo.net>
# Cookbook Name:: dlamp
# Recipe:: default
# Description:: Sets default values to use in building a Drupal Development
#   Environment
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

# Drush
default['drush']['install_method'] = "git"
default['drush']['version'] = "master"
default['drush']['install_dir'] = "/usr/share/drush"

# XDebug
default['xdebug']['remote_enable'] = 1
default['xdebug']['remote_connect_back'] = 1
default['xdebug']['version'] = "latest"
default['xdebug']['max_nesting_level'] = 500

# Composer
default['composer']['php_recipe'] = "apqc_php::default"

# APQC php
default['apqc_php']['php_version'] = '5.5'
default['apqc_php']['ini_defaults']['PHP']['display_errors'] = 'On'

# MySQL
default['mysql']['server_root_password'] = 'root'
default['mysql']['allow_remote_root'] = true
default['mysql']['bind_address'] = "0.0.0.0"
