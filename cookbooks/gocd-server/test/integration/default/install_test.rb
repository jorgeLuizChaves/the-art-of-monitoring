# # encoding: utf-8

# Inspec test for recipe gocd-server::install

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe package('curl') do
  it { should be_installed }
end

describe package('openjdk-8-jre') do
  it { should be_installed }
end

describe package('go-server') do
  it { should be_installed }
end