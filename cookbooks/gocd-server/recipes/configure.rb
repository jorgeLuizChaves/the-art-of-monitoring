#
# Cookbook:: gocd-server
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
template '/etc/apt/sources.list.d/gocd.list' do
  source 'gocd.list.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/tmp/GOCD-GPG-KEY.asc' do
  source 'GOCD-GPG-KEY.asc'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'gocd-key' do
  command 'apt-key add GOCD-GPG-KEY.asc'
  cwd '/tmp'
  action :run
end

apt_repository 'openjdk' do
  uri 'http://ppa.launchpad.net/openjdk-r/ppa/ubuntu xenial main'
  components ['main']
  action :add
end