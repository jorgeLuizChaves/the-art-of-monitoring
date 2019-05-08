# # encoding: utf-8

# Inspec test for recipe logstash::install

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('openjdk-8-jre') do
  it { should be_installed }
end

describe package('apt-transport-https') do
  it { should be_installed }
end

describe package('logstash') do
  it { should be_installed }
end