# # encoding: utf-8

# Inspec test for recipe riemann::setup

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe user('riemann') do
  it {should exist}
  its('shell') { should eq '/bin/false' }
end

describe directory('/etc/riemann') do
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
  its('mode') {should cmp '0755'}
end