require 'spec_helper'

describe 'stepped into mysql_test_default::server on fedora-19' do
  let(:fedora_19_default_run) do
    ChefSpec::Runner.new(
      :step_into => 'mysql_service',
      :platform => 'fedora',
      :version => '19'
      ) do |node|
      node.set['mysql']['service_name'] = 'fedora_19_default'
    end.converge('mysql_test_default::server')
  end

  let(:my_cnf_5_5_content_default_fedora_19) do
    '[client]
port                           = 3306
socket                         = /var/lib/mysql/mysql.sock

[mysqld_safe]
socket                         = /var/lib/mysql/mysql.sock

[mysqld]
user                           = mysql
pid-file                       = /var/run/mysqld/mysqld.pid
socket                         = /var/lib/mysql/mysql.sock
port                           = 3306
datadir                        = /var/lib/mysql

[mysql]
!includedir /etc/my.cnf.d
'
  end

  let(:grants_sql_content_default_fedora_19) do
    "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
UPDATE mysql.user SET Password=PASSWORD('ilikerandompasswords') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('ilikerandompasswords');
SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('ilikerandompasswords');"
  end

  before do
    stub_command("/usr/bin/mysql -u root -e 'show databases;'").and_return(true)
  end

  context 'when using default parameters' do
    it 'creates mysql_service[fedora_19_default]' do
      expect(fedora_19_default_run).to create_mysql_service('fedora_19_default').with(
        :version => '5.5',
        :port => '3306',
        :data_dir => '/var/lib/mysql'
        )
    end

    it 'steps into mysql_service and installs package[community-mysql-server]' do
      expect(fedora_19_default_run).to install_package('community-mysql-server')
    end

    it 'steps into mysql_service and creates directory[/etc/my.cnf.d]' do
      expect(fedora_19_default_run).to create_directory('/etc/my.cnf.d').with(
        :owner => 'mysql',
        :group => 'mysql',
        :mode => '0750',
        :recursive => true
        )
    end

    it 'steps into mysql_service and creates directory[/var/run/mysqld]' do
      expect(fedora_19_default_run).to create_directory('/var/run/mysqld').with(
        :owner => 'mysql',
        :group => 'mysql',
        :mode => '0755',
        :recursive => true
        )
    end

    it 'steps into mysql_service and creates directory[/var/lib/mysql]' do
      expect(fedora_19_default_run).to create_directory('/var/lib/mysql').with(
        :owner => 'mysql',
        :group => 'mysql',
        :mode => '0750',
        :recursive => true
        )
    end

    it 'steps into mysql_service and creates template[/etc/my.cnf]' do
      expect(fedora_19_default_run).to create_template('/etc/my.cnf').with(
        :owner => 'mysql',
        :group => 'mysql',
        :mode => '0600'
        )
    end

    it 'steps into mysql_service and renders file[/etc/my.cnf]' do
      expect(fedora_19_default_run).to render_file('/etc/my.cnf').with_content(
        my_cnf_5_5_content_default_fedora_19
        )
    end

    it 'steps into mysql_service and creates service[mysqld]' do
      expect(fedora_19_default_run).to start_service('mysqld')
      expect(fedora_19_default_run).to enable_service('mysqld')
    end

    it 'steps into mysql_service and runs execute[wait for mysql]' do
      expect(fedora_19_default_run).to run_execute('wait for mysql')
    end

    it 'steps into mysql_service and creates template[/etc/mysql_grants.sql]' do
      expect(fedora_19_default_run).to create_template('/etc/mysql_grants.sql').with(
        :owner => 'root',
        :group => 'root',
        :mode => '0600'
        )
    end

    it 'steps into mysql_service and renders file[/etc/mysql_grants.sql]' do
      expect(fedora_19_default_run).to render_file('/etc/mysql_grants.sql').with_content(
        grants_sql_content_default_fedora_19
        )
    end

    it 'steps into mysql_service and creates execute[install-grants]' do
      expect(fedora_19_default_run).to_not run_execute('install-grants').with(
        :command => '/usr/bin/mysql -u root -pilikerandompasswords < /etc/mysql_grants.sql'
        )
    end

    it 'steps into mysql_service and creates bash[move mysql data to datadir]' do
      expect(fedora_19_default_run).to_not run_bash('move mysql data to datadir')
    end

    it 'steps into mysql_service and creates execute[assign-root-password]' do
      expect(fedora_19_default_run).to run_execute('assign-root-password').with(
        :command => '/usr/bin/mysqladmin -u root password ilikerandompasswords'
        )
    end
  end
end
