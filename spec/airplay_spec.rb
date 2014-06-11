require 'spec_helper'

describe 'mythtv::airplay' do
  context 'when raop_key user is set' do
    subject {
      ChefSpec::Runner.new do |node|
        node.automatic_attrs[:etc][:passwd][:ubuntu][:dir] = '/home/ubuntu'
        node.set[:mythtv][:raop_key][:user] = 'ubuntu'
      end.converge(described_recipe)
    }

    it 'creates a remote_file containing the RAOP Key for Airplay' do
      expect(subject).to create_remote_file('/home/ubuntu/.mythtv/RAOPKey.rsa').with(owner: 'ubuntu')
    end

    it 'creates a profile.d script for setting MYTHTV_AIRPLAY=1' do
      profile_d_mythtv_airplay = '/etc/profile.d/mythtv_airplay.sh'
      expect(subject).to create_file(profile_d_mythtv_airplay).with(owner: 'root', group: 'root', mode: 0755)
      expect(subject).to render_file(profile_d_mythtv_airplay).with_content(/^export MYTHTV_AIRPLAY=1$/)
    end
  end

  context 'when raop_key user is NOT set' do
    let(:chef_run) {
      ChefSpec::Runner.new do |node|
        node.automatic_attrs[:etc][:passwd][:ubuntu][:dir] = '/home/ubuntu'
      end.converge(described_recipe)
    }

    it 'raises an error' do
      # Source: https://github.com/sethvargo/chefspec/blob/master/examples/expect_exception/spec/compile_error_spec.rb
      expect(Chef::Formatters::ErrorMapper).to_not receive(:file_load_failed)
      expect { chef_run }.to raise_error(RuntimeError)
    end
  end

  context 'when raop_key user is set, but home directory cannot be found' do
    let(:chef_run) {
      ChefSpec::Runner.new do |node|
        node.automatic_attrs[:etc][:passwd][:ubuntu] = nil
        node.set[:mythtv][:raop_key][:user] = 'ubuntu'
      end.converge(described_recipe)
    }

    it 'raises an error' do
      # Source: https://github.com/sethvargo/chefspec/blob/master/examples/expect_exception/spec/compile_error_spec.rb
      expect(Chef::Formatters::ErrorMapper).to_not receive(:file_load_failed)
      expect { chef_run }.to raise_error(RuntimeError)
    end
  end
end
