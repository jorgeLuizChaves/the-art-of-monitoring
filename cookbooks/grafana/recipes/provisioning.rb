#
# Cookbook:: grafana
# Recipe:: provisioning
#
# Copyright:: 2019, The Authors, All Rights Reserved.
directory '/etc/apt/sources.list.d' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

template '/etc/apt/sources.list.d/grafana.list' do
    source 'grafana.list.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

apt_update 'apt-update' do
    ignore_failure true
    action :update
end

apt_package 'curl' do
    action :install
end

execute 'add-grafana-key' do
    command 'curl https://packages.grafana.com/gpg.key | apt-key add -'
    action :run
end

