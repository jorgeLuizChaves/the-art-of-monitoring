#
# Cookbook:: logstash
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

include_recipe 'logstash::setup'
include_recipe 'logstash::install'
include_recipe 'logstash::configure'
include_recipe 'collectd::default'
include_recipe 'collectd::operational_system'
include_recipe 'collectd::riemann'
include_recipe 'collectd::logstash'