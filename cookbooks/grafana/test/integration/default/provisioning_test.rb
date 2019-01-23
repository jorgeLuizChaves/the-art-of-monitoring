# # encoding: utf-8

# Inspec test for recipe grafana::provisioning

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/apt/sources.list.d/grafana.list') do
  it { should exist }
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('content') { should match 'deb https://packages.grafana.com/oss/deb stable main'}
end

describe directory('/etc/apt/sources.list.d') do
  it { should be_directory }
  its('mode') { should cmp '0755'}
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
end

describe apt('https://packages.grafana.com/oss/deb') do
  it { should exist }
  it { should be_enabled }
end

describe package('curl') do
  it { should be_installed }
end