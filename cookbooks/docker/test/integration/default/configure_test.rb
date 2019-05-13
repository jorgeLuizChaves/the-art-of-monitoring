# # encoding: utf-8

# Inspec test for recipe docker::configure

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe directory('/etc/systemd/system/docker.service.d') do
  its('mode') {should cmp '0755'}
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
end

describe file('/etc/systemd/system/docker.service.d/override.conf') do
  its('mode') {should cmp '0644'}
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
end

describe file('/etc/docker/daemon.json') do
  its('mode') {should cmp '0644'}
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
end

describe systemd_service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe user("vagrant") do
  its('groups') { should include 'docker' }
end

describe file('/etc/default/docker') do
  its('mode') {should cmp '0644'}
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
end