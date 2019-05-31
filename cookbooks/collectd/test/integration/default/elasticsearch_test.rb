# # encoding: utf-8

# Inspec test for recipe collectd::elasticsearch

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/usr/lib/collectd/elasticsearch_collectd.py') do
  it {should exist}
  its('mode') {should cmp '0644'}
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
  its('md5sum') {should cmp '43fe1ee6149f4e66617bb6346dff98d8'}
end

describe file('/etc/collectd.d/elasticsearch.conf') do
  it {should exist}
  its('mode') {should cmp '0644'}
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
  its('md5sum') {should cmp 'cb95ae5f62f81a77dfd26ea76cfe09b3'}
end

describe file('/etc/collectd.d/elasticsearch_jmx.conf') do 
  it {should exist}
  its('mode') {should cmp '0644'}
  its('owner') {should eq 'root'}
  its('group') {should eq 'root'}
  its('md5sum') {should cmp '85e1d9e338cb31fef9c95d360694fcc2'}
end