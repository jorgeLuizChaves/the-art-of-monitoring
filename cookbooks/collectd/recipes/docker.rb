#
# Cookbook:: collectd
# Recipe:: docker
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

apt_package %w(unzip python-pip) do
  action :install
end


execute 'download docker collectd plugin' do
  command 'wget https://github.com/turnbullpress/docker-collectd-plugin/archive/master.zip'
  cwd '/tmp'
  action :run
  not_if "ls /usr/lib/collectd/docker"
end

execute 'unzip docker collectd plugin' do
  command 'unzip master.zip && mv docker-collectd-plugin-master/ docker'
  cwd '/tmp'
  action :run
  not_if "ls /usr/lib/collectd/docker"
end

execute 'name' do
  command 'mv docker /usr/lib/collectd/'
  cwd '/tmp'
  action :run
end

execute 'name' do
  command 'LC_ALL=en_US.UTF-8 pip install -r requirements.txt'
  cwd '/usr/lib/collectd/docker'
  action :run
end