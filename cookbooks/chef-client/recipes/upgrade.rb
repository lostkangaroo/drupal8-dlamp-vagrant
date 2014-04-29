# put this in `chef-client/recipes/upgrade.rb`

windows_package "Opscode Chef Client Installer for Windows v10.16.2" do
  source "https://www.opscode.com/chef/install.msi"
  action :install
end