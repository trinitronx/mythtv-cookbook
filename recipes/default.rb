case node[:platform_family]
when "rhel"
  return
when "debian"
  include_recipe 'apt'
  
  if MythbuntuPPA.supports_version?(node[:lsb][:codename], node[:mythtv][:version])
    mythbuntu_version = node[:mythtv][:version]
  else
    mythbuntu_version = MythbuntuPPA.latest_supported_version(node[:lsb][:codename])
  end

  apt_repository 'mythbuntu-ppa' do
    uri "http://ppa.launchpad.net/mythbuntu/#{mythbuntu_version}/ubuntu"
    distribution node[:lsb][:codename]
    components [:main]
    keyserver 'keyserver.ubuntu.com'
    key '0x1504888C'
    deb_src true
  end

end
