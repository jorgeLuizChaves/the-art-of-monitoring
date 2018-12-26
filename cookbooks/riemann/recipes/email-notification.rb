#
# Cookbook:: riemann
# Recipe:: email-notification
#
# Copyright:: 2018, The Authors, All Rights Reserved.
directory '/tmp/riemann-0.3.1/examplecom/etc' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template '/tmp/riemann-0.3.1/examplecom/etc/email.clj' do
  source 'email.clj'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end