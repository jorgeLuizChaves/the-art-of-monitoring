#
# Cookbook:: docker
# Recipe:: provisioning
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_update

apt_package %w(docker.io unzip python-pip) do
  action :install
end

# group 'docker' do
#   append true
#   members 'vagrant'
#   action :manage
# end

# execute 'download docker collectd plugin' do
#   command 'wget https://github.com/turnbullpress/docker-collectd-plugin/archive/master.zip'
#   cwd '/tmp'
#   action :run
# end

# execute 'unzip docker collectd plugin' do
#   command 'unzip master.zip && mv docker-collectd-plugin-master/ docker'
#   cwd '/tmp'
#   action :run
# end

# execute 'name' do
#   command 'mv docker /usr/lib/collectd/'
#   cwd '/tmp'
#   action :run
# end

# execute 'name' do
#   command 'LC_ALL=en_US.UTF-8 pip install -r requirements.txt'
#   cwd '/usr/lib/collectd/docker'
#   action :run
# end

# directory '/etc/systemd/system/docker.service.d' do
#   owner 'root'
#   group 'root'
#   mode '0755'
#   action :create
# end

# cookbook_file '/etc/systemd/system/docker.service.d/override.conf' do
#   source 'override.conf'
#   owner 'root'
#   group 'root'
#   mode '0755'
#   action :create
# end

# execute 'reload daemon' do
#   command 'systemctl daemon-reload'
#   action :run
# end

# service 'docker.service' do
#   action :restart
# end

