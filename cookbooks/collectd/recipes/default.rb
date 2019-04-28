#
# Cookbook:: collectd
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
user 'collectd' do
    comment 'collectd monitoring'
    system true
    shell '/bin/false'
    action :create
end

apt_repository 'collectd' do
    uri 'http://pkg.ci.collectd.org/deb'
    components ['collectd']
    action :add
end

apt_package 'collectd' do
    action :install
end

service 'collectd' do
    action :stop
end

directory '/etc/collectd.d/' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end


template '/etc/collectd/collectd.conf' do
    source 'collectd.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template '/etc/collectd.d/cpu.conf' do
    source 'cpu.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template '/etc/collectd.d/df.conf' do
    source 'df.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template '/etc/collectd.d/interface.conf' do
    source 'interface.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template '/etc/collectd.d/load.conf' do
    source 'load.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template '/etc/collectd.d/memory.conf' do
    source 'memory.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template '/etc/collectd.d/processes.conf' do
    source 'processes.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template '/etc/collectd.d/protocols.conf' do
    source 'protocols.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template '/etc/collectd.d/swap.conf' do
    source 'swap.conf'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

template '/etc/collectd.d/write_riemann.conf' do
  source 'write_riemann.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

execute 'sudo update-rc.d collectd defaults'

service 'collectd' do
    action :start
end

