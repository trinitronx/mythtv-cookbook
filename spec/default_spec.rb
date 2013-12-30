require 'spec_helper'

describe 'mythtv::default' do

  context 'on debian' do
    # subject { ChefSpec::Runner.new.converge described_recipe }
    subject(:chef_run) {
      chef_run = create_chefspec_runner do |node|
        node.default[:lsb][:codename] = 'precise'
        node.default[:platform_family] = 'debian'
      end
      chef_run.converge described_recipe
    }
    let(:lwrp) { chef_run.apt_repository('mythbuntu-ppa') }

    it { should include_recipe 'apt' }

    it { should add_apt_repository 'mythbuntu-ppa' }

  end
end