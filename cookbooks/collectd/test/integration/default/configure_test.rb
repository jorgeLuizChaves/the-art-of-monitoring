# # encoding: utf-8

# Inspec test for recipe collectd::configure

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe directory('/etc/collectd.d/') do 
  it {should exist}
  its('mode') {should cmp '0755'}
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
end

describe service('collectd') do 
  it{should be_running}
end