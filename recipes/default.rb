#
# Cookbook Name:: cv
# Recipe:: default
#
# Copyright (C) 2014 UAFGINA
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'build-essential'

node['cv']['dependencies'].each do |pkg|
  package pkg
end

remote_file "#{Chef::Config[:file_cache_path]}/#{cv_name}" do
  source node['cv']['url']
end

bash "build cv" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOC
  tar xvf #{cv_name}
  cd #{cv_build_dir}
  make
  make install
  EOC
  action :run
  not_if { ::File.exists?("/usr/bin/cv")}
end
