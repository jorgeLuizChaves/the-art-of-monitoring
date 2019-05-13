#
# Cookbook:: docker
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
apt_update 'apt-update' do
  ignore_failure true
  action :nothing
end

apt_package %w(docker.io unzip python-pip) do
  action :install
  notifies :update, 'apt_update[apt-update]', :before
end