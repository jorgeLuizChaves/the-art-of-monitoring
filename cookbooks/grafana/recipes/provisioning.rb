#
# Cookbook:: grafana
# Recipe:: provisioning
#
# Copyright:: 2019, The Authors, All Rights Reserved.

template '/etc/apt/sources.list.d/grafana.list' do
    source 'grafana.list.erb'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

apt_update 'apt-update' do
    ignore_failure true
    action :update
end

apt_package 'curl' do
    action :install
end

execute 'add-grafana-key' do
    command 'curl https://packages.grafana.com/gpg.key | apt-key add -'
    action :run
end

apt_update 'update' do
    ignore_failure true
    action :update
end
  
apt_package 'python-pip' do
    action :install
end
  
apt_package 'grafana' do
    action :install
end

# execute 'sudo update-rc.d grafana-server defaults'

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
