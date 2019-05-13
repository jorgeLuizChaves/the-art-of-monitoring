#
# Cookbook:: kibana
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
cookbook_file '/etc/kibana/kibana.yml' do
  source 'kibana.yml'
  owner 'root'
  group 'kibana'
  mode '0644'
  action :create
end

cookbook_file '/etc/timezone' do
  source 'timezone'
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

service 'rsyslog' do
  action :restart
end

service 'kibana' do
  action [:enable,:start]
end