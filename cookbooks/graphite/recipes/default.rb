#
# Cookbook:: graphite
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
apt_update 'update' do
  ignore_failure true
  action :update
end

package 'graphite-carbon' do
  action :install
end

package 'curl' do
  action :install
end


execute 'name' do
  command 'curl https://packagecloud.io/gpg.key | apt-key add -'
  action :run
end

execute 'name' do
  command 'sh -c "echo deb https://packagecloud.io/exoscale/community/ubuntu/ trusty main > /etc/apt/sources.list.d/exoscale_community.list"'
  action :run
end

package 'apt-transport-https' do
  action :install
end

apt_update 'update' do
  ignore_failure true
  action :update
end

package 'graphite-api' do
  action :install
end



