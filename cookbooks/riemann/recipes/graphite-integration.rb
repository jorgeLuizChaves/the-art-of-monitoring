#
# Cookbook:: riemann
# Recipe:: graphite-integration
#
# Copyright:: 2018, The Authors, All Rights Reserved.
directory '/tmp/riemann-0.3.1/examplecom/etc' do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
end

template '/tmp/riemann-0.3.1/examplecom/etc/graphite.clj' do
    source 'graphite.clj'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end
