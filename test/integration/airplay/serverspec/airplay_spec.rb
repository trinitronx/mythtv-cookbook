require 'spec_helper'

describe file('/home/vagrant/.mythtv') do
  it { should be_directory }
  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }
  it { should be_mode 755 }
end

describe file('/home/vagrant/.mythtv/RAOPKey.rsa') do
  it { should be_file }
  it { should match_md5checksum '43bd3a097ab64ac6cf15fcf28c1db615' }
end

describe file('/etc/profile.d/mythtv_airplay.sh') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 644 }
  its(:content) { should match /^export MYTHTV_AIRPLAY=1$/ }
end
