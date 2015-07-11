require 'spec_helper'

describe file("/usr/bin/php") do
  it { should be_file }
  it { should be_executable }
end

describe package('php5-cli') do
  it { should be_installed }
end
