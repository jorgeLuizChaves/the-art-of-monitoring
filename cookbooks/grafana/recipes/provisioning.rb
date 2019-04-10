#
# Cookbook:: grafana
# Recipe:: provisioning
#
# Copyright:: 2019, The Authors, All Rights Reserved.

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

cookbook_file '/tmp/gpg.key' do
    source 'gpg.key'
    owner 'root'
    group 'root'
    mode '0664'
    action :create
end

execute 'add-grafana-key' do
    command 'apt-key add gpg.key'
    cwd '/tmp'
    action :run
end

apt_update 'update' do
    ignore_failure true
    action :update
end
  
apt_package %w(curl python-pip grafana) do
    action :install
end

# execute 'sudo update-rc.d grafana-server defaults'

node.default['grafana']['plugins'].each do |plugin|
    execute "sudo grafana-cli plugins install #{plugin}"
end 

service 'grafana-server' do
  action :restart
end