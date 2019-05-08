# # encoding: utf-8

# Inspec test for recipe logstash::configure

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe file('/etc/logstash/conf.d/logstash.conf') do
  its('mode') {should cmp '0644' }
  its('owner') {should eq 'root' }
  its('group') {should eq 'root' }
end

describe service('logstash') do
  it { should be_installed }
  it { should be_running }
end
