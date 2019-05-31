# # encoding: utf-8

# Inspec test for recipe riemann::install

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('openjdk-8-jre') do
  it {should be_installed}
end

describe package('ruby') do 
  it {should be_installed}
end

describe package('leiningen') do 
  it {should be_installed}
end

describe package('ruby-dev') do
  it {should be_installed}
end

describe package('zlib1g-dev') do 
  it {should be_installed}
end

describe package('build-essential') do 
  it {should be_installed}
end