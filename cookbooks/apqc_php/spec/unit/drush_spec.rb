require 'spec_helper'

# TODO: git_client resource fails.
# describe 'apqc_php::drush' do
#   let(:chef_run) do
#     ChefSpec::SoloRunner.new do |node|
#       node.set['lsb']['codename'] = 'precise'
#       node.set['drush']['install_method'] = 'git'
#     end.converge(described_recipe)
#   end

#   it 'includes cli recipe' do
#     expect(chef_run).to include_recipe('apqc_php::cli')
#   end

#   it 'includes drush recipe' do
#     expect(chef_run).to include_recipe('drush::git')
#   end
# end
