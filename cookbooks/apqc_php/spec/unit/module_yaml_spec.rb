require 'spec_helper'

describe 'apqc_php::module_yaml' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['lsb']['codename'] = 'precise'
    end.converge(described_recipe)
  end

  it 'installs uuid-dev requirement' do
    expect(chef_run).to install_package('libyaml-dev')
  end
  it 'installs pecl extension' do
    expect(chef_run).to run_apqc_php_pecl_extension('yaml')
  end
end
