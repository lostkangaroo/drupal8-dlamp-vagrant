name             'user_account'
maintainer       'Texas A&M'
maintainer_email 'jarosser06@gmail.com'
license          'MIT'
description      'Provides a resource for user_account'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'

%w(ubuntu centos omnios suse).each do |os|
  supports os
end
