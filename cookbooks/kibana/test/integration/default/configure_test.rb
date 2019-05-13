# # encoding: utf-8

# Inspec test for recipe kibana::configure

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/apt/sources.list.d/elastic-7.x.list') do
  its('mode') { should cmp '0644'}
  its('owner') { should eq 'root'}
  its('group') { should eq 'root'}
end

describe file('/etc/rsyslog.d/30-logstash.conf') do
  its('mode') { should cmp '0644'}
  its('owner') { should eq 'root'}
  its('group') { should eq 'root'}
  its('md5sum') { should eq '7dcee23e58b0052e5d12e0475326a9ba' }
end