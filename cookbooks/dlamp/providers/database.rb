#
# Author:: Andrew Jungklaus <lostkangaroo@lostkangaroo.net>
# Cookbook Name:: dlamp
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

def load_current_resource
  #
end

action :create do
  Chef::Log.info new_resource.name

  connection_info = {
    host: '127.0.0.1',
    username: 'root',
    password: node['mysql']['server_root_password']
  }

  mysql_database new_resource.name do
    connection connection_info
    action :create
  end

  new_resource.users.each do |user, pass|
    mysql_database_user user do
      connection connection_info
      database_name new_resource.name
      password pass
      host '%'
      action :grant
    end
  end
end
