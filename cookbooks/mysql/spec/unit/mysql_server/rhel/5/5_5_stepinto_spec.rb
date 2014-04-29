require 'spec_helper'

describe 'stepped into mysql_test_custom::server 5.5 on centos-5.8' do
  let(:centos_5_8_custom3_run) do
    ChefSpec::Runner.new(
      :step_into => 'mysql_service',
      :platform => 'centos',
      :version => '5.8'
      ) do |node|
      node.set['mysql']['service_name'] = 'centos_5_8_custom3'
      node.set['mysql']['version'] = '5.5'
      node.set['mysql']['port'] = '3308'
      node.set['mysql']['data_dir'] = '/data'
      node.set['mysql']['template_source'] = 'custom.erb'
      node.set['mysql']['allow_remote_root'] = true
      node.set['mysql']['remove_anonymous_users'] = false
      node.set['mysql']['remove_test_database'] = false
      node.set['mysql']['root_network_acl'] = ['10.9.8.7/6', '1.2.3.4/5']
      node.set['mysql']['server_root_password'] = 'YUNOSETPASSWORD'
      node.set['mysql']['server_debian_password'] = 'postinstallscriptsarestupid'
      node.set['mysql']['server_repl_password'] = 'syncmebabyonemoretime'
    end.converge('mysql_test_custom::server')
  end

  let(:my_cnf_5_5_content_custom3_centos_5_8) do
    'This my template. There are many like it but this one is mine.'
  end

  let(:grants_sql_content_custom3_centos_5_8) do
    "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' identified by 'syncmebabyonemoretime';
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'YUNOSETPASSWORD' WITH GRANT OPTION;
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('YUNOSETPASSWORD');
SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('YUNOSETPASSWORD');
GRANT ALL PRIVILEGES ON *.* TO 'root'@'10.9.8.7/6' IDENTIFIED BY 'YUNOSETPASSWORD' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'1.2.3.4/5' IDENTIFIED BY 'YUNOSETPASSWORD' WITH GRANT OPTION;"
  end

  before do
    stub_command("/opt/rh/mysql55/root/usr/bin/mysql -u root -e 'show databases;'").and_return(true)
  end

  context 'when using default parameters' do
    it 'creates mysql_service[centos_5_8_custom3]' do
      expect(centos_5_8_custom3_run).to create_mysql_service('centos_5_8_custom3').with(
        :version => '5.5',
        :port => '3308',
        :data_dir => '/data'
        )
    end

    it 'steps into mysql_service and installs package[mysql55-mysql-server]' do
      expect(centos_5_8_custom3_run).to install_package('mysql55-mysql-server')
    end

    it 'steps into mysql_service and creates directory[/opt/rh/mysql55/root/etc/mysql/conf.d]' do
      expect(centos_5_8_custom3_run).to create_directory('/opt/rh/mysql55/root/etc/mysql/conf.d').with(
        :owner => 'mysql',
        :group => 'mysql',
        :mode => '0750',
        :recursive => true
        )
    end

    it 'steps into mysql_service and creates directory[/opt/rh/mysql55/root/var/run/mysqld/]' do
      expect(centos_5_8_custom3_run).to create_directory('/opt/rh/mysql55/root/var/run/mysqld/').with(
        :owner => 'mysql',
        :group => 'mysql',
        :mode => '0755',
        :recursive => true
        )
    end

    it 'steps into mysql_service and creates directory[/data]' do
      expect(centos_5_8_custom3_run).to create_directory('/data').with(
        :owner => 'mysql',
        :group => 'mysql',
        :mode => '0750',
        :recursive => true
        )
    end

    it 'steps into mysql_service and creates template[/opt/rh/mysql55/root/etc/my.cnf]' do
      expect(centos_5_8_custom3_run).to create_template('/opt/rh/mysql55/root/etc/my.cnf').with(
        :owner => 'mysql',
        :group => 'mysql',
        :mode => '0600'
        )
    end

    it 'steps into mysql_service and renders file[/opt/rh/mysql55/root/etc/my.cnf]' do
      expect(centos_5_8_custom3_run).to render_file('/opt/rh/mysql55/root/etc/my.cnf').with_content(
        my_cnf_5_5_content_custom3_centos_5_8
        )
    end

    it 'steps into mysql_service and creates service[mysql55-mysqld]' do
      expect(centos_5_8_custom3_run).to start_service('mysql55-mysqld')
      expect(centos_5_8_custom3_run).to enable_service('mysql55-mysqld')
    end

    it 'steps into mysql_service and waits for mysql to start' do
      expect(centos_5_8_custom3_run).to run_execute('wait for mysql').with(
        :command => 'until [ -S /var/lib/mysql/mysql.sock ] ; do sleep 1 ; done',
        :timeout => 10
        )
    end

    it 'steps into mysql_service and creates execute[assign-root-password]' do
      expect(centos_5_8_custom3_run).to run_execute('assign-root-password').with(
        :command => '/opt/rh/mysql55/root/usr/bin/mysqladmin -u root password YUNOSETPASSWORD'
        )
    end

    it 'steps into mysql_service and creates template[/etc/mysql_grants.sql]' do
      expect(centos_5_8_custom3_run).to create_template('/etc/mysql_grants.sql').with(
        :cookbook => 'mysql',
        :owner => 'root',
        :group => 'root',
        :mode => '0600'
        )
    end

    it 'steps into mysql_service and creates execute[install-grants]' do
      expect(centos_5_8_custom3_run).to_not run_execute('install-grants').with(
        :command => '/usr/bin/mysql -u root -pYUNOSETPASSWORD < /etc/mysql_grants.sql'
        )
    end

    it 'steps into mysql_service and renders file[/opt/rh/mysql55/root/etc/my.cnf]' do
      expect(centos_5_8_custom3_run).to render_file('/opt/rh/mysql55/root/etc/my.cnf').with_content(
        my_cnf_5_5_content_custom3_centos_5_8
        )
    end

    it 'steps into mysql_service and creates bash[move mysql data to datadir]' do
      expect(centos_5_8_custom3_run).to_not run_bash('move mysql data to datadir')
    end

    it 'steps into mysql_service and writes log[notify restart]' do
      expect(centos_5_8_custom3_run).to write_log('notify restart')
    end

    it 'steps into mysql_service and writes log[notify reload]' do
      expect(centos_5_8_custom3_run).to write_log('notify reload')
    end
  end
end
