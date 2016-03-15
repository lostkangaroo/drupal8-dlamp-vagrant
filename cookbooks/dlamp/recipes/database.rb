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

mysql2_chef_gem 'default' do
  action :install
end

Chef::Log.info "Attempting to locate databag dlamp_database"

if Chef::DataBag.list.key?('dlamp_database')
  begin
    dlamp_dbs = data_bag('dlamp_database').collect do |item|
      db = data_bag_item('dlamp_database', item)

      dlamp_database db['db_name'] do
        users db['db_users']
        action :create
      end
    end
  rescue
    Chef::Log.warn "Could not load data bag 'dlamp_database'"
  end
end

if node['dlamp']['database']
  node['dlamp']['database'].each do |db|
    dlamp_database db['db_name'] do
      users db['db_users']
    end
  end
end
