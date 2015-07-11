actions :create, :delete
default_action :create

attribute :sapi, kind_of: String
attribute :settings, kind_of: Hash, default: {}
