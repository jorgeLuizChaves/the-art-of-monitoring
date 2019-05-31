# # encoding: utf-8

# Inspec test for recipe elasticsearch::configure

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe file('/etc/elasticsearch/elasticsearch.yml') do
  it {should exist}
  its('owner') {should eq 'root'}
  its('group') {should eq 'elasticsearch'}

end

describe file('/etc/elasticsearch/jvm.options') do
  it {should exist}
  its('owner') {should eq 'root'}
  its('group') {should eq 'elasticsearch'}
  its('mode') { should cmp '0660'}
  its('md5sum') {should cmp '2559d61494d6aca96a7c566f7ff19a9b'}
end

describe service('elasticsearch') do 
  it {should be_running }
end