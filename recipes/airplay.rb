user = node[:mythtv][:raop_key][:user] # user set in cookbook attrubute
# user = node['current_user'] # user running chef cookbook (on provisioned host)

Chef::Log.error('For Airplay support, you must set node[:mythtv][:raop_key][:user] to the user you wish to install the RAOPKey for (e.g. The desktop user you run mythfrontend as)') if user.nil?

begin
  home = node['etc']['passwd'][user]['dir']
rescue NoMethodError
  Chef::Log.error("Could not determine home directory for user: #{user}")
ensure
  raise 'A desktop user and home directory must exist to install the Airplay RAOPKey' if home.nil?
end

remote_file "#{home}/.mythtv/RAOPKey.rsa" do
  owner     user
  source    node[:mythtv][:raop_key][:url]
  checksum  node[:mythtv][:raop_key][:checksum]
  mode      0644
  action    :create
end