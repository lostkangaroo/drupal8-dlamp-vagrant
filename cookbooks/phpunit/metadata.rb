name 'phpunit'
maintainer 'Escape Studios'
maintainer_email 'dev@escapestudios.com'
license 'MIT'
description 'Installs/Configures PHPUnit'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.2'

%w( debian ubuntu redhat centos fedora scientific amazon ).each do |os|
  supports os
end

depends 'php'
depends 'git'
depends 'composer'

recipe 'phpunit', 'Installs phpunit.'
recipe 'phpunit::composer', 'Installs phpunit using composer.'
recipe 'phpunit::pear', 'Installs phpunit using pear.'
recipe 'phpunit::phar', 'Installs phpunit using phar.'
