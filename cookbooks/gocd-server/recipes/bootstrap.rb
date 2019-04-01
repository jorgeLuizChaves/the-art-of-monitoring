#
# Cookbook:: gocd-server
# Recipe:: bootstrap
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_update 'apt-update' do
    ignore_failure true
    action :nothing
end

apt_package 'curl' do
    action :install
    notifies :update, 'apt_update[apt-update]', :before
end

template '/etc/apt/sources.list.d/gocd.list' do
    source 'gocd.list.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

execute 'gocd-key' do
    command 'curl https://download.gocd.org/GOCD-GPG-KEY.asc | apt-key add -'
    action :run
    notifies :update, 'apt_update[apt-update]', :immediately
end

apt_package 'openjdk-8-jre' do
    action :install
end

apt_package 'go-server' do
    action :install
end


