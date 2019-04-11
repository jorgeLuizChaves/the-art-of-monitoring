#
# Cookbook:: gocd-server
# Recipe:: bootstrap
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_update 'apt-update' do
    ignore_failure true
    action :nothing
end

template '/etc/apt/sources.list.d/gocd.list' do
    source 'gocd.list.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

cookbook_file '/tmp/GOCD-GPG-KEY.asc' do
    source 'GOCD-GPG-KEY.asc'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

execute 'gocd-key' do
    command 'apt-key add GOCD-GPG-KEY.asc'
    cwd '/tmp'
    action :run
end

apt_update 'apt-update' do
    ignore_failure true
    action :update
end

apt_repository 'openjdk' do
    uri 'http://ppa.launchpad.net/openjdk-r/ppa/ubuntu xenial main'
    components ['main']
    action :add
end

apt_package %w(curl openjdk-8-jre go-server) do
    action :install
    notifies :update, 'apt_update[apt-update]', :before
end