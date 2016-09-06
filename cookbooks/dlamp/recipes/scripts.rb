#
# Author:: Andrew Jungklaus <lostkangaroo@lostkangaroo.net>
# Cookbook Name:: dlamp
# Recipe:: scripts
# Description:: Runs scripts at the completion of all other things.
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

Chef::Log.info "Attempting to locate databag dlamp_scripts"

if Chef::DataBag.list.key?('dlamp_scripts')
  begin
    scripts = data_bag('dlamp_scripts').collect do |item|
      script = data_bag_item('dlamp_scripts', item)

      execute script['file'] do
        command script['file']
        user "vagrant"
      end
    end
  rescue
    Chef::Log.warn "Could not load data bag 'dlamp_scripts'"
  end
end

if node['dlamp']['scripts']
  node['dlamp']['scripts'].each do |script|
    execute script['file'] do
      command script['file']
      user "vagrant"
    end
  end
end