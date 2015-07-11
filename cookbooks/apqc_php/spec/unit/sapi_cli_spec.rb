require 'spec_helper'

describe 'apqc_php::sapi_cli' do
  shared_examples 'standard behavior' do
    it 'includes default recipe' do
      expect(chef_run).to include_recipe('apqc_php::default')
    end

    it 'installs php5-cli' do
      expect(chef_run).to install_package('php5-cli')
    end
  end

  context 'default run' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['lsb']['codename'] = 'precise'
      end.converge(described_recipe)
    end

    it 'renders php.ini' do
      expect(chef_run).to run_apqc_php_php_ini('/etc/php5/cli/php.ini')
    end

    it_behaves_like 'standard behavior'
  end

  context 'skip php.ini' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['lsb']['codename'] = 'precise'
        node.set['apqc_php']['ini_files']['cli'] = false
      end.converge(described_recipe)
    end
    it 'renders php.ini' do
      expect(chef_run).to_not run_apqc_php_php_ini('/etc/php5/cli/php.ini')
    end

    it_behaves_like 'standard behavior'
  end
end
