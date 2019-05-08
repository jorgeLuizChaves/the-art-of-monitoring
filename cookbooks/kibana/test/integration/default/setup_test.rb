# # encoding: utf-8

# Inspec test for recipe kibana::setup

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe file('/etc/kibana/kibana.yml') do
  its('mode') {should cmp '0644'}
  its('owner') {should eq 'root'}
  its('group') {should eq 'kibana'}
end

describe service('kibana') do
  it {should be_running }
end
