require 'spec_helper'
require 'net/http'

describe port(80) do
  it { should be_listening }
end

describe file("/etc/apache2/mods-enabled/php5.conf") do
  it { should be_file }
  # its(:content) { should match /ServerName test/ }
end
describe file("/etc/apache2/mods-enabled/php5.load") do
  it { should be_file }
  # its(:content) { should match /ServerName test/ }
end
