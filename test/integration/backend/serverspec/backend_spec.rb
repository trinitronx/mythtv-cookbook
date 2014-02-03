require 'spec_helper'

describe package('mythtv-backend') do
  it { should be_installed }
end

describe service('mythtv-backend') do
  it { should be_enabled }
end

describe file('/usr/local/bin/mythshutdowncheck.sh') do
  it { should be_file }
  it { should be_mode 755 }
end

describe file('/usr/local/bin/setwaketime.sh') do
  it { should be_file }
  it { should be_mode 755 }
end

describe cron do
  it { should have_entry('6 0 * * * /usr/share/doc/mythtv-backend/contrib/maintenance/optimize_mythdb.pl').with_user('mythtv') }
end
