#
# Cookbook:: riemann
# Recipe:: provisioning
#
# Copyright:: 2018, The Authors, All Rights Reserved.

riemann_version = '0.3.1'
apt_update 'update'

user 'riemann' do
  comment 'riemann monitoring'
  system true
  shell '/bin/false'
  action :create
end


package %w(openjdk-8-jre ruby ruby-dev build-essential zlib1g-dev leiningen) do
  action :install
end

execute "download riemann #{node.default['riemann']['version']}" do
  command "wget https://github.com/riemann/riemann/releases/download/#{node.default['riemann']['version']}/riemann-#{node.default['riemann']['version']}.tar.bz2 --no-check-certificate"
  cwd "/tmp"
  action :run
  not_if "ls /tmp/riemann-#{node.default['riemann']['version']}.tar.bz2"
end

execute "extract riemann #{node.default['riemann']['version']}" do
  command "tar xvfj riemann-#{node.default['riemann']['version']}.tar.bz2 -C /usr/bin"
  cwd "/tmp"
  action :run
  not_if "ls /usr/bin/riemann-#{node.default['riemann']['version']}/"
end

link "/usr/bin/riemann" do
  to "/usr/bin/riemann-#{node.default['riemann']['version']}"
  link_type :symbolic
end

execute 'install riemann-tools' do
  command 'gem install --no-ri --no-rdoc riemann-tools'
  action :run
end

directory '/etc/riemann' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "/etc/riemann/riemann.config" do
  source 'riemann.sample.async.clj'
  owner 'root'
  group 'root'
  mode '0664'
  action :create
end

cookbook_file '/lib/systemd/system/riemann.service' do
  source 'riemann.service'
  owner 'root'
  group 'root'
  mode '0644'
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
  action :sync
end

service 'riemann' do
  action :restart
end
