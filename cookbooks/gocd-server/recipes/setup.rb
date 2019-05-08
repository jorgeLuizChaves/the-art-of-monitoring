#
# Cookbook:: gocd-server
# Recipe:: setup
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
file '/etc/rsyslog.d/go-server.conf' do
  source 'go-server.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

file '/etc/rsyslog.d/30-logstash.conf' do
  source '30-logstash.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

service 'rsyslog' do
  action :restart
end

service 'go-server' do
  action [:enable,:start]
end