# Default Values to use

# MySQL
node.default['mysql']['server_root_password'] = 'root'
node.default['mysql']['allow_remote_root'] = true
node.default['mysql']['bind_address'] = "0.0.0.0"

# Drush
node.default['drush']['install_method'] = "git"
node.default['drush']['version'] = "master"
node.default['drush']['install_dir'] = "/usr/share/drush"

# XDebug
node.default['xdebug']['remote_enable'] = 1
node.default['xdebug']['remote_connect_back'] = 1
node.default['xdebug']['idekey'] = "PHPSTORM"
node.default['xdebug']['version'] = "latest"

# Composer
node.default['composer']['php_recipe'] = "apqc_php::php"

# Recipe Run List
require_recipe "apt"
require_recipe "apache2"
require_recipe "mysql::server"
require_recipe "apqc_php::php"
require_recipe "apqc_php::drush"
require_recipe "vhost"
require_recipe "xdebug"
