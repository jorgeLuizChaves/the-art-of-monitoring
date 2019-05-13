# # encoding: utf-8

# Inspec test for recipe logstash::setup

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/apt/sources.list.d/elastic-7.x.list') do
  its('md5sum') { should eq 'dfaee0a93727d56ba715bf1b2bc9fe9c' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('mode') { should cmp '0644' }
end

describe file('/etc/localtime') do
  its('mode') { should cmp '0644' }
  its('link_path') { should eq '/usr/share/zoneinfo/Etc/GMT+3' }
end