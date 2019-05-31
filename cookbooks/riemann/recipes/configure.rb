#
# Cookbook:: riemann
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
link "/usr/bin/riemann" do
  to "/usr/bin/riemann-#{node.default['riemann']['version']}"
  link_type :symbolic
end

# directory "#{node.default['riemann']['code_dir']}" do
#   owner 'root'
#   group 'root'
#   mode '0755'
#   recursive true
#   action :create
# end

remote_directory "#{node.default['riemann']['code_dir']}" do
  source 'riemann-source-code'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute "extract riemann #{node.default['riemann']['version']}" do
  command "tar xvfj riemann-#{node.default['riemann']['version']}.tar.bz2 -C /usr/bin"
  cwd "/tmp"
  action :run
  not_if "ls /usr/bin/riemann-#{node.default['riemann']['version']}/"
end

cookbook_file "/etc/riemann/riemann.config" do
  source 'riemann.sample.async.clj'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/lib/systemd/system/riemann.service' do
  source 'riemann.service'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/hosts' do
  source 'hosts'
  owner 'root'
  group 'root'
  mode '644'
  action :create
end

git '/tmp' do
  repository 'https://github.com/samn/riemann-syntax-check.git'
  action :sync
end

service 'riemann' do
  action :restart
end