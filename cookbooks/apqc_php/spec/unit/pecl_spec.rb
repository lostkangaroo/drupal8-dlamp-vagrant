require 'spec_helper'

describe 'apqc_php::pecl' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['lsb']['codename'] = 'precise'
    end.converge(described_recipe)
  end

  it 'installs php-pecl requirement' do
    expect(chef_run).to install_package('php-pear')
  end
  it 'installs php5-dev requirement' do
    expect(chef_run).to install_package('php5-dev')
  end
  it 'installs make requirement' do
    expect(chef_run).to install_package('make')
  end
end
