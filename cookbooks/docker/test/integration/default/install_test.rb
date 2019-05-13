# # encoding: utf-8

# Inspec test for recipe docker::install

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
describe package('docker.io') do
  it {should be_installed}
end

describe package('unzip') do
  it {should be_installed}
end

describe package('python-pip') do
  it {should be_installed}
end