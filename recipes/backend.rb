#
# Cookbook Name:: mythtv
# Recipe:: backend
#
# Copyright 2011, Chris Peplin
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
#

include_recipe 'mythtv::default'
include_recipe 'mysql::server'

package 'mythtv-backend' do
  retry_delay 1
  retries 2
end

service 'mythtv-backend' do
    if (platform?('ubuntu') && node[:platform_version].to_f >= 10.04)
      provider Chef::Provider::Service::Upstart
    end
    supports :status => true, :restart => true
    action :enable
end

%w{mythshutdowncheck.sh setwaketime.sh}.each do |script|
  cookbook_file "/usr/local/bin/#{script}" do
    mode 0755
  end
end

cron 'optimize database' do
  hour '0'
  minute '6'
  command '/usr/share/doc/mythtv-backend/contrib/maintenance/optimize_mythdb.pl'
  user 'mythtv'
end
