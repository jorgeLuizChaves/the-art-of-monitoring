# # encoding: utf-8

# Inspec test for recipe gocd-server::setup

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe service('go-server') do
  it { should be_running }
end

describe file('/etc/rsyslog.d/30-logstash.conf') do
  its('mode') { should cpm '0644'}
  its('owner') { should eq 'root'}
  its('group') { should eq 'root'}
end