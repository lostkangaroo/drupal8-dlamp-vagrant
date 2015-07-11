require 'spec_helper'

describe package('php5-mysql') do
  it { should be_installed }
end
describe package('php5-gd') do
  it { should be_installed }
end
describe package('php5-memcache') do
  it { should be_installed }
end
describe package('php-apc') do
  it { should be_installed }
end
describe package('php5-mcrypt') do
  it { should be_installed }
end
describe package('php5-curl') do
  it { should be_installed }
end
