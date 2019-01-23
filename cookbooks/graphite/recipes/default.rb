#
# Cookbook:: graphite
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
apt_update 'update' do
  ignore_failure true
  action :update
end

package 'graphite-carbon' do
  action :install
end

package 'curl' do
  action :install
end

execute 'name' do
  command 'echo "deb https://packagecloud.io/exoscale/community/ubuntu/ trusty main" >> /etc/apt/sources.list.d/exoscale_community.list'
  action :run
  not_if "ls /etc/apt/sources.list.d/exoscale_community.list"
end

execute 'name' do
  command 'curl https://packagecloud.io/gpg.key | apt-key add -'
  action :run
end

package 'apt-transport-https' do
  action :install
end

apt_update 'update' do
  ignore_failure true
  action :update
end

package 'gunicorn3' do
  action :install
end

package 'graphite-api' do
  action :install
end

template '/etc/graphite-api.yaml' do
  source 'graphite-api.yaml'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'grafana-repository' do
  command 'echo "deb https://packages.grafana.com/oss/deb stable main" >> /etc/apt/sources.list.d/grafana.list'
  action :run
  not_if "cat /etc/apt/sources.list.d/grafana.list | grep grafana"
end

execute 'name' do
  command 'curl https://packages.grafana.com/gpg.key | sudo apt-key add -'
  action :run
end

apt_update 'update' do
  ignore_failure true
  action :update
end

package 'python-pip' do
  action :install
end

package 'grafana' do
  action :install
end

template '/etc/carbon/carbon.conf' do
  source 'carbon.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template '/etc/carbon/storage-schemas.conf' do
  source 'storage-schemas.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template '/var/lib/graphite/api_search_index' do
  source 'api_search_index'
  owner '_graphite'
  group '_graphite'
  mode '0755'
  action :create
end

template '/etc/init.d/carbon-cache' do
  source 'carbon-cache'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/init.d/carbon-relay' do
  source 'carbon-relay'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/default/graphite-carbon' do
  source 'graphite-carbon'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/lib/systemd/system/graphite-api.service' do
  source 'graphite-api.service'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/lib/systemd/system/graphite-api.socket' do
  source 'graphite-api.socket'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/grafana/grafana.ini' do
  source 'grafana.ini'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

template '/etc/grafana/ldap.toml' do
  source 'ldap.toml'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

service 'grafana-server' do
  action :stop
end

service 'carbon-cache' do
  action :stop
end

service 'carbon-relay' do
  action :stop
end

service 'grafana' do
  action :stop
end

service 'graphite-api' do
  action :stop
end

execute 'sudo update-rc.d carbon-cache defaults'

execute 'sudo update-rc.d carbon-relay defaults'

execute 'sudo update-rc.d grafana-server defaults'

execute 'sudo update-rc.d graphite-api defaults'

execute 'name' do
  command 'sudo grafana-cli plugins install grafana-kubernetes-app'
  action :run
end

execute 'sudo grafana-cli plugins install grafana-polystat-panel'

execute 'sudo grafana-cli plugins install camptocamp-prometheus-alertmanager-datasource'

execute 'sudo grafana-cli plugins install vonage-status-panel'

execute 'sudo grafana-cli plugins install snuids-trafficlights-panel'

execute 'sudo grafana-cli plugins install grafana-worldmap-panel'

execute 'sudo grafana-cli plugins install raintank-worldping-app'

execute 'sudo grafana-cli plugins install grafana-piechart-panel'

execute 'sudo grafana-cli plugins install sbueringer-consul-datasource'

execute 'sudo grafana-cli plugins install briangann-gauge-panel'

execute 'sudo grafana-cli plugins install ayoungprogrammer-finance-datasource'

execute 'sudo grafana-cli plugins install savantly-heatmap-panel'

execute 'sudo grafana-cli plugins install mtanda-histogram-panel'

execute 'sudo grafana-cli plugins install digiapulssi-organisations-panel'

execute 'sudo grafana-cli plugins install snuids-radar-panel'

service 'grafana-server' do
  action :restart
end

service 'carbon-cache' do
  action :restart
end

service 'carbon-relay' do
  action :restart
end

service 'graphite-api' do
  action :restart
end






