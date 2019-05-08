#
# Cookbook:: elasticsearch
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
# execute 'name' do
#   command 'wget https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz'
#   cwd '/tmp'
#   action :run
# end
include_recipe "elk::default"
include_recipe "elasticsearch::setup"
include_recipe "elasticsearch::install"
include_recipe "elasticsearch::configure"