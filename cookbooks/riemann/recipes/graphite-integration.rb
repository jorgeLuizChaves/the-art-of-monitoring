#
# Cookbook:: riemann
# Recipe:: graphite-integration
#
# Copyright:: 2018, The Authors, All Rights Reserved.
directory "#{node.default['riemann']['code_dir']}" do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
end

template "#{node.default['riemann']['code_dir']}/graphite.clj" do
    source 'graphite.clj'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

cookbook_file "#{node.default['riemann']['code_dir']}/logstash.clj" do
    source 'logstash.clj'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end


template "#{node.default['riemann']['code_dir']}/collectd.clj" do
    source 'collectd.clj'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

template "#{node.default['riemann']['code_dir']}/slack.clj" do
    source 'slack.clj'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

cookbook_file "#{node.default['riemann']['code_dir']}/checks.clj" do
    source 'checks.clj'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

# template '/tmp/riemann-0.3.1/riemann-0.3.2-SNAPSHOT-standalone.jar' do
#     source 'riemann-0.3.2-SNAPSHOT-standalone.jar'
#     owner 'root'
#     group 'root'
#     mode '0664'
#     action :create
# end

# template '/tmp/riemann-0.3.1/riemann-0.3.2-SNAPSHOT.jar' do
#     source 'riemann-0.3.2-SNAPSHOT-standalone.jar'
#     owner 'root'
#     group 'root'
#     mode '0664'
#     action :create
# end

# file '/tmp/riemann-0.3.1/riemann-0.3.2-SNAPSHOT.jar' do
#     owner 'root'
#     group 'root'
#     mode '0664'
#     action :create
# end