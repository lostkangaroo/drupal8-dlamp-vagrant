case platform_family
when 'debian', 'rhel', 'suse'
  default['user_account']['home_root'] = '/home'
  default['user_account']['default_shell'] = '/bin/bash'
when 'omnios', 'smartos'
  default['user_account']['home_root'] = '/export/home'
  default['user_account']['default_shell'] = '/bin/bash'
end
