#
# Cookbook:: riemann
# Recipe:: provisioning
#
# Copyright:: 2018, The Authors, All Rights Reserved.

riemann_version = '0.3.1'
apt_update 'update'

package 'openjdk-8-jre' do
  action :install
end

execute "download riemann #{riemann_version}" do
  command "wget https://github.com/riemann/riemann/releases/download/#{riemann_version}/riemann-#{riemann_version}.tar.bz2 --no-check-certificate"
  cwd "/tmp"
  action :run
  not_if "ls /tmp/riemann-#{riemann_version}.tar.bz2"
end

execute "extract riemann #{riemann_version}" do
  command "tar xvfj riemann-#{riemann_version}.tar.bz2"
  cwd "/tmp"
  action :run
end

package 'ruby' do
  action :install
end

package 'ruby-dev' do
  action :install
end

package 'build-essential' do
  action :install
end

package 'zlib1g-dev' do
  action :install
end

package 'leiningen' do
  action :install
end

execute 'install riemann-tools' do
  command 'gem install --no-ri --no-rdoc riemann-tools'
  action :run
end

template "/tmp/#{riemann_version}/etc/riemann.config" do
  source 'riemann.sample.async.clj'
  owner 'vagrant'
  group 'vagrant'
  mode '0664'
  action :create
end

template '/etc/hosts' do
  source 'hosts'
  owner 'root'
  group 'root'
  mode '644'
  action :create
end

git '/tmp' do
  repository 'https://github.com/samn/riemann-syntax-check.git'
  revision 'revision'
  action :sync
end