require 'spec_helper'

describe file('/etc/apt/sources.list.d/mythbuntu-ppa.list') do
  it { should be_file }
  its(:content) { should match /deb(-src)?\s+(\[arch=amd64\]\s+)?https?:\/\/ppa.launchpad.net\/mythbuntu\/([0-9.]+)\/ubuntu\/?\s+(lucid|maverick|natty|oneiric|precise|quantal|raring|saucy|trusty)\s+(main)/ }
end

describe command('gpg --ignore-time-conflict --no-options --no-default-keyring --secret-keyring /etc/apt/secring.gpg --trustdb-name /etc/apt/trustdb.gpg --keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg --fingerprint 427BA16F0EC4E54037AD4C3F13551B881504888C') do
  its(:stdout) { should match /^pub\s+1024R\/1504888C/ }
  its(:stdout) { should match /^\s*Key\s*fingerprint\s*=\s*427B\s*A16F\s*0EC4\s*E540\s*37AD\s*4C3F\s*1355\s*1B88\s*1504\s*888C/ }
end