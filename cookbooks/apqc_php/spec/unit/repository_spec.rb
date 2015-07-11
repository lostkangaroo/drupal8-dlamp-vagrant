require 'spec_helper'

describe 'apqc_php::repository' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['lsb']['codename'] = 'precise'
    end.converge(described_recipe)
  end

  it 'creates apt repository' do
    expect(chef_run).to add_apt_repository('ondrej-php5')
  end
end
