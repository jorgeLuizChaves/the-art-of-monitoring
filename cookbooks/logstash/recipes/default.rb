#
# Cookbook:: logstash
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
execute 'logstash-public-key' do
    command 'wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -'
    action :run
end

template '/etc/apt/sources.list.d/elastic-6.x.list' do
    source 'elastic-6.x.list.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

apt_update 'update' do
    ignore_failure true
    action :update
end

apt_package 'openjdk-8-jre' do
    action :install
end

apt_package 'apt-transport-https' do
    action :install
end

apt_package 'logstash' do
    action :install
end






