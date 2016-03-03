#
# Author:: Andrew Jungklaus <lostkangaroo@lostkangaroo.net>
# Cookbook Name:: dlamp
# Recipe:: default
# Description:: Sets a runlist to use in building a Drupal Development
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

# Create Common Web Directory /var/www
directory "/var/www" do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

# Recipe Run List
include_recipe "apt"
include_recipe "logrotate"
include_recipe "apache2"
include_recipe "apache2::mod_headers"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_env"
include_recipe "apache2::mod_setenvif"
include_recipe "apache2::mod_alias"
include_recipe "apache2::mod_status"
include_recipe "apache2::mod_negotiation"
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_expires"
include_recipe "dlamp::mysql"
include_recipe "sqlite"
include_recipe "apqc_php::default"
include_recipe "apqc_php::sapi_mod_php"
include_recipe "apqc_php::module_mysql"
include_recipe "apqc_php::module_gd"
include_recipe "apqc_php::module_apc"
include_recipe "apqc_php::module_curl"
include_recipe "apqc_php::module_mcrypt"
include_recipe "apqc_php::module_memcache"
include_recipe "apqc_php::module_memcached"
# include_recipe "apqc_php::module_uuid"
# include_recipe "apqc_php::module_yaml"

# Run these the old fashioned way since the above recipes don't seem to be working correctly
execute 'install_yaml' do
  command 'sudo pecl install yaml'
end

execute 'install_uuid' do
  command 'sudo pecl install uuid'
end

include_recipe "php::module_sqlite3"
include_recipe "apache2::mod_php5"
include_recipe "apqc_php::drush"
include_recipe "vhost"
include_recipe "xdebug"
include_recipe "phpunit"
include_recipe "dlamp::database"
include_recipe "dlamp::git_checkout"
include_recipe "dlamp::scripts"
