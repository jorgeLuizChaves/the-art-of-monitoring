#
# Cookbook:: docker
# Recipe:: configure
#
# Copyright:: 2019, Jorge Luiz Chaves
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
group 'docker' do
  append true
  members "#{node.default['ssh']['user']}"
  action :manage
end

directory '/etc/systemd/system/docker.service.d' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/systemd/system/docker.service.d/override.conf' do
  source 'override.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template '/etc/default/docker' do
  source 'docker.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/rsyslog.d/30-logstash.conf' do
  source '30-logstash.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

execute 'reload daemon' do
  command 'systemctl daemon-reload'
  action :run
end

service 'rsyslog' do
  action :restart
end


service 'docker.service' do
  action [ :enable, :restart ]
end