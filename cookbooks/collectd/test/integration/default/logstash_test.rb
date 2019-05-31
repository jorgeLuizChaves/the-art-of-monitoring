# # encoding: utf-8

# Inspec test for recipe collectd::jvm

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe file('/etc/collectd.d/logstash_jmx.conf') do
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
  its('md5sum') {should eq '85e1d9e338cb31fef9c95d360694fcc2'}
end

describe file('/etc/collectd.d/logstash.conf') do
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
  its('md5sum') {should eq 'dd33dcc9f625ac4636b34e3d75c4bb3c'}
end