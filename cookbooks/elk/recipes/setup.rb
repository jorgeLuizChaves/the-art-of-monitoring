#
# Cookbook:: elk
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
execute 'add elk key' do
  command 'wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -'
  action :run
end

cookbook_file '/etc/apt/sources.list.d/elastic-7.x.list' do
  source 'setup/elastic-7.x.list'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end