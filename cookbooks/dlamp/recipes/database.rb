#
# Author:: Andrew Jungklaus <lostkangaroo@lostkangaroo.net>
# Cookbook Name:: dlamp
# Recipe:: database
# Description:: Creates empty default database
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

Chef::Log.info "Attempting to locate databag dlamp_database"

if Chef::DataBag.list.key?('dlamp_database')
  begin
    node['dlamp_database'] ||= []

    databases = data_bag('dlamp_database').collect do |item|
      database = data_bag_item('dlamp_database', item)

      node['dlamp_database'] << database
    end

  rescue
    Chef::Log.info "Could not load data bag 'dlamp_database'"
  end
end

mysql2_chef_gem 'default' do
  action :install
end

if node['dlamp_database']
  node['dlamp_database'].each do |db|
    mysql_database db['db_name'] do
      connection(
        :host => '127.0.0.1',
        :username => 'root',
        :password => node['mysql']['server_root_password']
      )
      action :create
    end

    db['db_users'].each do |user|
      mysql_database_user user['username'] do
        connection connection_info
        password user['password']
        host '%'
        action :grant
      end
    end
  end
end
