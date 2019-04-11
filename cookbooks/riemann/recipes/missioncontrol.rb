#
# Cookbook:: riemann
# Recipe:: missioncontrol
#
# Copyright:: 2018, The Authors, All Rights Reserved.
template '/tmp/riemann-0.3.1/etc/riemann.config' do
    source 'riemann.mission.control.config.clj'
    owner 'vagrant'
    group 'vagrant'
    mode '0664'
    action :create
end