# # encoding: utf-8

# Inspec test for recipe collectd::setup

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe user('collectd') do 
  it {should exist}
  its('shell') {should eq '/bin/false'}
end