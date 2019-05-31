#
# Cookbook:: collectd
# Recipe:: operational_system
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
cookbook_file '/etc/collectd.d/cpu.conf' do
  source 'os/cpu.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/collectd.d/df.conf' do
  source 'os/df.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/collectd.d/interface.conf' do
  source 'os/interface.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/collectd.d/load.conf' do
  source 'os/load.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/collectd.d/memory.conf' do
  source 'os/memory.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/collectd.d/protocols.conf' do
  source 'os/protocols.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/collectd.d/swap.conf' do
  source 'os/swap.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

service 'collectd' do
  action :restart
end
