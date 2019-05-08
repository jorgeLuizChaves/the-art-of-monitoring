# # encoding: utf-8

# Inspec test for recipe elk::install

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

1_minute = 60

describe file('/var/cache/apt/srcpkgcache.bin') do
  its('mtime') { should <= Time.now.to_i }
  its('mtime') { should >= Time.now.to_i - 1_minute }
end

describe file('/var/cache/apt/pkgcache.bin') do
  its('mtime') { should <= Time.now.to_i }
  its('mtime') { should >= Time.now.to_i - 1_minute }
end

describe package('apt-transport-https') do
  it { should be_installed }
end

describe package('openjdk-8-jre') do
  it { should be_installed }
end