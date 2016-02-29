actions :create, :delete
default_action :create

attribute :destination, kind_of: String
attribute :deploy_key, kind_of: String, default: ''
attribute :repo, kind_of: String
attribute :revision, kind_of: String, default: 'master'
attribute :fdqn, kind_of: String, default: 'master'
