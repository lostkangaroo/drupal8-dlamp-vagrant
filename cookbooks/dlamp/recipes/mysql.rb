#
# Author:: Andrew Jungklaus <lostkangaroo@lostkangaroo.net>
# Cookbook Name:: dlamp
# Recipe:: mysql
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

mysql_service 'mysql' do
  port '3306'
  version '5.5'
  initial_root_password :server_root_password
  action [:create, :start]
end

mysql_config 'mysql' do
  source 'mysql_config.cnf.erb'
  notifies :restart, 'mysql_service[mysql]'
  action :create
end
