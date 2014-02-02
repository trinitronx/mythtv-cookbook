require 'spec_helper'

describe package('mythtv-frontend') do
  it { should be_installed }
end

