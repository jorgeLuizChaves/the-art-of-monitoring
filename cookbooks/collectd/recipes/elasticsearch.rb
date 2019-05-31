#
# Cookbook:: collectd
# Recipe:: elasticsearch
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
cookbook_file '/usr/lib/collectd/elasticsearch_collectd.py' do
  source 'elasticsearch/elasticsearch_collectd.py'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/collectd.d/elasticsearch.conf' do
  source 'elasticsearch/elasticsearch.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/collectd.d/elasticsearch_jmx.conf' do
  source 'elasticsearch/elasticsearch_jmx.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end


service 'collectd' do
  action :restart
end

