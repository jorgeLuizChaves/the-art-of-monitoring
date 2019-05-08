# # encoding: utf-8

# Inspec test for recipe elasticsearch::configure

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe file('/etc/elasticsearch/elasticsearch.yml') do 
  its('owner') {should eq 'root'}
  its('group') {should eq 'elasticsearch'}

end

describe service('elasticsearch') do 
  it {should be_running }
end
