require 'spec_helper'

describe file("/usr/bin/drush") do
  it { should be_file }
end
describe file("/usr/bin/php") do
  it { should be_file }
  it { should be_executable }
end
