# # encoding: utf-8

# Inspec test for recipe gocd-server::bootstrap

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/apt/sources.list.d/gocd.list') do
  it { should exist }
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('content') { should match 'deb https://download.gocd.org /'}
end

describe package('go-server') do
  it { should be_installed }
end

describe package('openjdk-8-jre') do
  it { should be_installed }
end