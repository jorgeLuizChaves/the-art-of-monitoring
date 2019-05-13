#
# Cookbook:: logstash
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

include_recipe 'logstash::setup'
include_recipe 'logstash::install'
include_recipe 'logstash::configure'