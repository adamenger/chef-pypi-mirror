#
# Cookbook Name:: pypi
# Recipe:: default
#
# Copyright 2013, skinnyCorp & Adam Enger
#

include_recipe 'python'

package 'nginx'

directory node[:pypi][:install_directory] do
  user node[:pypi][:username]
  group node[:pypi][:groupname]
end

template "#{node[:pypi][:install_directory]}/requirements.txt" do
  source 'requirements.txt.erb'
  user node[:pypi][:username]
  group node[:pypi][:groupname]
end

virtualenv = "#{node[:pypi][:install_directory]}/env"

python_virtualenv virtualenv do
  owner node[:pypi][:username]
  group node[:pypi][:groupname]
end

python_requirements "#{node[:pypi][:install_directory]}/requirements.txt" do
  username node[:pypi][:username]
  virtualenv_dir virtualenv
end

# pypi packages will be downloaded to this directory
directory node[:pypi][:mirror_directory] do
  user node[:pypi][:username]
  group node[:pypi][:groupname]
  mode 0755
end

# web is created by the bandersnatch cronjob if it doesn't already exist
# but to make sure that lighttpd has it's document root we'll create it
# explicitly here:
directory "#{node[:pypi][:mirror_directory]}/web" do
  user node[:pypi][:username]
  group node[:pypi][:groupname]
  mode 0755
end

# now that bandersnatch is installed configure it:
template '/etc/bandersnatch.conf' do
  source 'bandersnatch.conf.erb'
end

execute "clean up left over nginx bits" do
  command "rm -rf /etc/nginx/sites-{enabled,available}/*"
end

template '/etc/nginx/sites-enabled/pypi_mirror' do
  source 'pypi_mirror.vhost.erb'
  notifies :restart, 'service[nginx]', :delayed
end

service 'nginx' do
  supports :restart => true, :stop => true, :start => true
  action [:restart, :enable]
end

# configure cron to run bandersnatch mirror at 5:45 daily:
cron 'pypi_mirror' do
  minute '*/2'
  command "#{node[:pypi][:install_directory]}/env/bin/bandersnatch mirror"
end

# official / public pypi mirrors should crunch their stats:
cron 'pypi_stats' do
  minute '12'
  command "#{node[:pypi][:install_directory]}/env/bin/bandersnatch update-stats"
end
