# # encoding: utf-8

# Inspec test for recipe elk::setup

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/apt/sources.list.d/elastic-7.x.list') do
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
  its('md5sum') { should eq 'dfaee0a93727d56ba715bf1b2bc9fe9c'}
end

describe file('/etc/apt/trusted.gpg') do
  its('mtime') { should <= Time.now.to_i }
  its('mtime') { should >= Time.now.to_i - 1000 }
end