#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
#
# APQC copy of the php attributes file.
#
# Cookbook Name:: apqc_php
# Attribute:: php
#
# Copyright 2011, Opscode, Inc.
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

# This file has been heavily altered to be cleaned up and extended with
# new features like the FPM groups.

lib_dir = kernel['machine'] =~ /x86_64/ ? 'lib64' : 'lib'

case node['platform_family']
when 'rhel', 'fedora'
  default['apqc_php']['conf_dir']      = '/etc'
  default['apqc_php']['ext_conf_dir']  = '/etc/php.d'
  default['apqc_php']['fpm_user']      = 'nobody'
  default['apqc_php']['fpm_group']     = 'nobody'
  default['apqc_php']['ext_dir']       = "/usr/#{lib_dir}/php/modules"
when 'debian'
  default['apqc_php']['conf_dir']      = '/etc/php5'
  default['apqc_php']['ext_conf_dir']  = '/etc/php5/mods-available'
  default['apqc_php']['fpm_user']      = 'www-data'
  default['apqc_php']['fpm_group']     = 'www-data'
  case node['platform']
  when 'ubuntu'
    case node['platform_version']
    when '15.04'
      default['apqc_php']['ext_dir'] = '/usr/lib/php5/20131226'
    when '14.04'
      default['apqc_php']['ext_dir'] = '/usr/lib/php5/20121212'
    when '12.04'
      default['apqc_php']['ext_dir'] = '/usr/lib/php5/20090626'
    else
      default['apqc_php']['ext_dir'] = '/usr/lib/php5/' + node['platform_version']
    end
  end
else
  default['apqc_php']['conf_dir']      = '/etc/php5'
  default['apqc_php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['apqc_php']['fpm_user']      = 'www-data'
  default['apqc_php']['fpm_group']     = 'www-data'
end

#### INI SETTINGS ###

default['apqc_php']['ini_files']['root'] = false
default['apqc_php']['ini_files']['apache2'] = true
default['apqc_php']['ini_files']['cli'] = true
default['apqc_php']['ini_files']['cgi'] = false
default['apqc_php']['ini_files']['fpm'] = true

# overides for specific files.
default['apqc_php']['ini_overrides']['root'] = false
default['apqc_php']['ini_overrides']['apache2'] = false
default['apqc_php']['ini_overrides']['cli'] = false
default['apqc_php']['ini_overrides']['cgi'] = false
default['apqc_php']['ini_overrides']['fpm'] = false

# "Extra" group directives to be added to all ini files.
default['apqc_php']['directives'] = {}

# Default ini values. Grouped by section.
default['apqc_php']['ini_defaults']['PHP'] = {
  'engine' => 'On',
  'short_open_tag' => 'Off',
  'asp_tags' => 'Off',
  'precision' => 14,
  'output_buffering' => 4096,
  'zlib.output_compression' => 'Off',
  'implicit_flush' => 'Off',
  'serialize_precision' => 100,
  'safe_mode' => 'Off',
  # 'safe_mode_gid' => 'Off',
  # 'safe_mode_allowed_env_vars' => 'PHP_',
  # 'safe_mode_protected_env_vars' => 'LD_LIBRARY_PATH',
  'expose_php' => 'Off',
  'max_execution_time' => 30,
  'max_input_time' => 60,
  'memory_limit' => '128M',
  'error_reporting' => 'E_ALL & ~E_DEPRECATED',
  'display_errors' => 'Off',
  'display_startup_errors' => 'Off',
  'log_errors' => 'Off',
  'log_errors_max_len' => 1024,
  'ignore_repeated_errors' => 'Off',
  'ignore_repeated_source' => 'Off',
  'report_memleaks' => 'On',
  'track_errors' => 'Off',
  'html_errors' => 'On',
  'variables_order' => 'GPCS',
  'request_order' => 'GP',
  # 'register_globals' => 'Off',
  # 'register_long_arrays' => 'Off',
  'register_argc_argv' => 'Off',
  'auto_globals_jit' => 'On',
  'post_max_size' => '8M',
  # 'magic_quotes_gpc' => 'Off',
  # 'magic_quotes_runtime' => 'Off',
  # 'magic_quotes_sybase' => 'Off',
  'default_mimetype' => 'text/html',
  'enable_dl' => 'Off',
  'file_uploads' => 'On',
  'upload_max_filesize' => '2M',
  'max_file_uploads' => 20,
  'allow_url_fopen' => 'On',
  'allow_url_include' => 'Off',
  'default_socket_timeout' => 60
}
default['apqc_php']['ini_defaults']['Pdo_mysql'] = {
  'pdo_mysql.cache_size' => 2000
}
default['apqc_php']['ini_defaults']['Syslog'] = {
  'define_syslog_variables ' => 'Off'
}
default['apqc_php']['ini_defaults']['mail function'] = {
  'SMTP' => 'localhost',
  'smtp_port' => 25,
  'mail.add_x_header' => 'On'
}
default['apqc_php']['ini_defaults']['SQL'] = {
  'sql.safe_mode' => 'Off'
}
default['apqc_php']['ini_defaults']['ODBC'] = {
  'odbc.allow_persistent' => 'On',
  'odbc.check_persistent' => 'On',
  'odbc.max_persistent' => -1,
  'odbc.max_links' => -1,
  'odbc.defaultlrl' => 4096,
  'odbc.defaultbinmode' => 1
}
default['apqc_php']['ini_defaults']['Interbase'] = {
  'ibase.allow_persistent' => 1,
  'ibase.max_persistent' => -1,
  'ibase.max_links' => -1,
  'ibase.timestampformat' => '%Y-%m-%d %H:%M:%S',
  'ibase.dateformat' => '%Y-%m-%d',
  'ibase.timeformat' => '%H:%M:%S'
}
default['apqc_php']['ini_defaults']['MySQL'] = {
  'mysql.allow_local_infile' => 'On',
  'mysql.allow_persistent' => 'On',
  'mysql.cache_size' => 2000,
  'mysql.max_persistent' => -1,
  'mysql.max_links' => -1,
  'mysql.connect_timeout' => 60,
  'mysql.trace_mode' => 'Off'
}
default['apqc_php']['ini_defaults']['MySQLi'] = {
  'mysqli.max_persistent' => -1,
  'mysqli.allow_persistent' => 'On',
  'mysqli.max_links' => -1,
  'mysqli.cache_size' => 2000,
  'mysqli.default_port' => 3306,
  'mysqli.reconnect' => 'Off'
}
default['apqc_php']['ini_defaults']['mysqlnd'] = {
  'mysqlnd.collect_statistics' => 'On',
  'mysqlnd.collect_memory_statistics' => 'Off'
}
default['apqc_php']['ini_defaults']['PostgresSQL'] = {
  'pgsql.allow_persistent' => 'On',
  'pgsql.auto_reset_persistent' => 'Off',
  'pgsql.max_persistent' => -1,
  'pgsql.max_links' => -1,
  'pgsql.ignore_notice' => 0,
  'pgsql.log_notice' => 0
}
default['apqc_php']['ini_defaults']['Sybase-CT'] = {
  'sybct.allow_persistent' => 'On',
  'sybct.max_persistent' => -1,
  'sybct.max_links' => -1,
  'sybct.min_server_severity' => 10,
  'sybct.min_client_severity' => 10
}
default['apqc_php']['ini_defaults']['bcmath'] = {
  'bcmath.scale' => 0
}
default['apqc_php']['ini_defaults']['Session'] = {
  'session.save_handler' => 'files',
  'session.use_cookies' => 1,
  'session.use_only_cookies' => 1,
  'session.name' => 'PHPSESSID',
  'session.auto_start' => 0,
  'session.cookie_lifetime' => 0,
  'session.cookie_path' => '/',
  'session.serialize_handler' => 'php',
  'session.gc_probability' => 1,
  'session.gc_divisor' => 1000,
  'session.gc_maxlifetime' => 1440,
  'session.bug_compat_42' => 'Off',
  'session.bug_compat_warn' => 'Off',
  'session.entropy_length' => 0,
  'session.cache_limiter' => 'nocache',
  'session.cache_expire' => 180,
  'session.use_trans_sid' => 0,
  'session.hash_function' => 0,
  'session.hash_bits_per_character' => 5,
  'url_rewriter.tags' => 'a=href,area=href,frame=src,input=src,form=fakeentry'
}
default['apqc_php']['ini_defaults']['MSSQL'] = {
  'mssql.allow_persistent' => 'On',
  'mssql.max_persistent' => -1,
  'mssql.max_links' => -1,
  'mssql.min_error_severity' => 10,
  'mssql.min_message_severity' => 10,
  'mssql.compatability_mode' => 'Off',
  'mssql.secure_connection' => 'Off'
}
default['apqc_php']['ini_defaults']['Tidy'] = {
  'tidy.clean_output' => 'Off'
}
default['apqc_php']['ini_defaults']['soap'] = {
  'soap.wsdl_cache_enabled' => 1,
  'soap.wsdl_cache_dir' => '/tmp',
  'soap.wsdl_cache_ttl' => 86_400,
  'soap.wsdl_cache_limit' => 5
}
default['apqc_php']['ini_defaults']['ldap'] = {
  'ldap.max_links' => -1
}
