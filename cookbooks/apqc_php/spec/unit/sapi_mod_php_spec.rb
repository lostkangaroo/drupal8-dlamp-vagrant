require 'spec_helper'

describe 'apqc_php::sapi_mod_php' do
  # let(:chef_run) do
  #   ChefSpec::SoloRunner.new do |node|
  #     node.set['lsb']['codename'] = 'precise'
  #   end.converge(described_recipe)
  # end

  shared_examples 'standard behavior' do
    it 'includes default recipe' do
      stub_command('/usr/sbin/apache2 -t').and_return(true)
      expect(chef_run).to include_recipe('apqc_php::default')
    end

    it 'includes apache2::mod_php5 recipe' do
      stub_command('/usr/sbin/apache2 -t').and_return(true)
      expect(chef_run).to include_recipe('apache2::mod_php5')
    end
  end

  context 'default run' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['lsb']['codename'] = 'precise'
      end.converge(described_recipe)
    end

    it 'renders php.ini' do
      stub_command('/usr/sbin/apache2 -t').and_return(true)
      expect(chef_run).to run_apqc_php_php_ini('/etc/php5/apache2/php.ini')
    end

    it_behaves_like 'standard behavior'
  end

  context 'skip php.ini' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['lsb']['codename'] = 'precise'
        node.set['apqc_php']['ini_files']['apache2'] = false
      end.converge(described_recipe)
    end

    it 'renders php.ini' do
      stub_command('/usr/sbin/apache2 -t').and_return(true)
      expect(chef_run).to_not run_apqc_php_php_ini('/etc/php5/apache2/php.ini')
    end

    it_behaves_like 'standard behavior'
  end
end
