# # encoding: utf-8

# Inspec test for recipe elasticsearch::setup

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/timezone') do
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('md5sum') { should eq '4f24b133ba38d8fd565168742c9aedeb'}
end
