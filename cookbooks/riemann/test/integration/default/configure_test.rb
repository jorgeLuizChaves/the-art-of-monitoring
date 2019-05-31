# # encoding: utf-8

# Inspec test for recipe riemann::configure

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe file('/etc/riemann/riemann.config') do
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
  its('mode') {should cmp '0644'}
end

describe file('/lib/systemd/system/riemann.service') do
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
  its('mode') {should cmp '0644'}
end

describe service('riemann') do
  it { should be_running }
end