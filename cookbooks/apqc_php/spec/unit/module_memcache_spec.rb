require 'spec_helper'

describe 'apqc_php::module_memcache' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['lsb']['codename'] = 'precise'
    end.converge(described_recipe)
  end

  it 'installs php5-memcache' do
    expect(chef_run).to install_package('php5-memcache')
  end
end
