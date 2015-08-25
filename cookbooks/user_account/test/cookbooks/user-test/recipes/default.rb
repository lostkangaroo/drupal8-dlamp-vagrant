user_account 'jim' do
  action :create
  uid 1026
  password 'flibertyjibbits'
  groups ['wheel']
end

user_account 'rob' do
  action :create
  uid 1020
  ssh_keys "this is not a real ssh key"
end

user_account 'remove_jim' do
  username 'jim'
  action :remove
end

user_account 'jenny' do
  exclude_nodes node.name
  action :create
end

user_account 'jackie' do
  include_nodes node.name
  uid '1080'
  action :create
end

group 'users' do
  action :create
end

user_account 'richard' do
  gid 'users'
  ssh_keys "this is not a real ssh key"
  action :create
end

user_account 'adam' do
  gid 0
  ssh_keys "this is not a real ssh key"
  action :create
end

user_account 'remove_adam' do
  username 'adam'
  action :remove
end

user_account 'frank' do
  uid 1030
  ssh_keys "this is not a real ssh key"
  action :create
end

user_account 'remove_frank' do
  username 'frank'
  delete_home_dir false
  action :remove
end
