#
# Cookbook:: logstash
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
group 'adm' do
  append true
  members 'logstash'
  action :modify
end

template '/etc/logstash/conf.d/logstash.conf' do
  source 'logstash.conf.erb'
  mode '0644'
end

service 'logstash' do
  action [:enable,:start, :restart]
end