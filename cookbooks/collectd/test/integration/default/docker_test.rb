# # encoding: utf-8

# Inspec test for recipe collectd::docker

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe directory('/usr/lib/collectd/docker') do
  its('owner') { should eq 'root'}
  its('group') { should eq 'root'}
  its('mode') { should cmp '0755'}
end