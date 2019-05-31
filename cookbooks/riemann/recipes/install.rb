#
# Cookbook:: riemann
# Recipe:: install
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
apt_update 'update'

package %w(openjdk-8-jre ruby ruby-dev build-essential zlib1g-dev leiningen) do
  action :install
end

execute "download riemann #{node.default['riemann']['version']}" do
  command "wget https://github.com/riemann/riemann/releases/download/#{node.default['riemann']['version']}/riemann-#{node.default['riemann']['version']}.tar.bz2 --no-check-certificate"
  cwd "/tmp"
  action :run
  not_if "ls /usr/bin/riemann-#{node.default['riemann']['version']}"
end

execute "extract riemann #{node.default['riemann']['version']}" do
  command "tar xvfj riemann-#{node.default['riemann']['version']}.tar.bz2 -C /usr/bin"
  cwd "/tmp"
  action :run
  not_if "ls /usr/bin/riemann-#{node.default['riemann']['version']}/"
end

execute 'install riemann-tools' do
  command 'gem install --no-ri --no-rdoc riemann-tools'
  action :run
end