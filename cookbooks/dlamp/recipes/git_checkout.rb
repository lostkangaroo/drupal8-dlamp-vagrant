#
# Author:: Andrew Jungklaus <lostkangaroo@lostkangaroo.net>
# Cookbook Name:: dlamp
# Recipe:: git_checkout
# Description:: Clones a Git repo from specific locations with or without rsa keys
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

Chef::Log.info "Attempting to locate databag dlamp_git_checkout"

if Chef::DataBag.list.key?('dlamp_git_checkout')
  repos = data_bag('dlamp_git_checkout').collect do |item|
    repo = data_bag_item('dlamp_git_checkout', item)
    dlamp_git_checkout repo['id'] do
      destination repo['destination']
      deploy_key repo['deploy_key']
      repo repo['repo']
      revision repo['revision']
      fdqn repo['fdqn']
    end
  end
end

node['dlamp']['git_checkout'].each do |repo|
  dlamp_git_checkout repo['id'] do
    destination repo['destination']
    deploy_key repo['deploy_key']
    repo repo['repo']
    revision repo['revision']
    fdqn repo['fdqn']
  end
end