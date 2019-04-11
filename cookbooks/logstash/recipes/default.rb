#
# Cookbook:: logstash
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

cookbook_file '/tmp/GPG-KEY-elasticsearch' do
    source 'GPG-KEY-elasticsearch'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

execute 'logstash-public-key' do
    command 'apt-key add GPG-KEY-elasticsearch'
    cwd '/tmp'
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

apt_package %w(openjdk-8-jre apt-transport-https logstash) do
    action :install
end