require 'spec_helper'
require 'mythbuntu_ppa'

RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    owner.const_defined?(const)
  end
end

describe LSB do
  let(:lsb_codenames) { {
      :lucid    => '10.04',
      :maverick => '10.10',
      :natty    => '11.04',
      :oneiric  => '11.10',
      :precise  => '12.04',
      :quantal  => '12.10',
      :raring   => '13.04',
      :saucy    => '13.10',
      :trusty   => '14.04'
    }
  }

  it { LSB.should have_constant :CODENAMES }

  it 'should contain a map of codenames to versions' do
    LSB::CODENAMES.should eq lsb_codenames
  end
end

describe MythbuntuPPA do
  let(:lsb_codenames) { LSB::CODENAMES }

  MythbuntuPPA::VERSIONS.each do |mythtv_version, codenames|
    codenames.each do |codename|
      it "version #{mythtv_version} should support #{codename} (#{LSB::CODENAMES[codename]})" do
        MythbuntuPPA.supported_versions(codename.to_s).should include mythtv_version
      end
    end
  end

  it "#latest_supported_version should always return the highest version supported" do
    lsb_codenames.each do |codename, ubuntu_version|
      MythbuntuPPA.latest_supported_version(codename).should eq MythbuntuPPA.supported_versions(codename).sort.reverse[0]
    end
  end

  it 'should raise an error when passed an invalid lsb codename' do
    expect { MythbuntuPPA.supported_versions(:unwise) }.to raise_error Chef::Exceptions::InvalidPlatformVersion
  end

  it 'should raise an error when passed an unsupported potential future lsb codename' do
    [:undead, :wascally, :xenophobic].each do |future_version|
      expect { MythbuntuPPA.supported_versions(future_version) }.to raise_error Chef::Exceptions::InvalidPlatformVersion
    end
  end

  MythbuntuPPA::VERSIONS.each do |mythtv_version, valid_codenames|
    valid_codenames.each do |valid_codename|      
      it "#supports_version?(#{valid_codename}, #{mythtv_version}) should return true for valid versions" do
        expect { MythbuntuPPA.supports_version?(mythtv_version, valid_codename) }.to_not raise_error
        MythbuntuPPA.supports_version?(valid_codename, mythtv_version).should be_true
      end

      [nil, false, 0, 1, 2, '0.278'].each do |invalid_mythtv_version|
        it "#supports_version?(#{valid_codename}, #{invalid_mythtv_version}) should return false for invalid mythtv versions" do
          MythbuntuPPA.supports_version?(valid_codename, invalid_mythtv_version).should be_false
        end
      end
    end

    [:undead, :wascally, :xenophobic].each do |future_version|
      it "#supports_version?(#{future_version}, #{mythtv_version}) should return false for unsupported LSB codenames" do
        MythbuntuPPA.supports_version?(future_version, mythtv_version).should be_false
      end
    end
  end
end