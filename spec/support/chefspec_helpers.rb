require 'chefspec'

module ChefSpecHelpers
  def setup_chefspec

    ## Lots of crappy boilerplate stuff we need to do for chefspec to work with (encrypted) data bags
    Chef::Config[:data_bag_path] = File.join(File.dirname(__FILE__), '../../test/integration/data_bags')
    Chef::Config[:solo] = true
    Chef::Config[:encrypted_data_bag_secret] = "#{ENV['HOME']}/.chef/encrypted_data_bag_secret"
  end
  def create_chefspec_runner(options={})
    setup_chefspec
    
    options.merge!({ :cookbook_path => COOKBOOK_PATH })

    if block_given?
      chef_run = ChefSpec::Runner.new(options, &Proc.new)
    else
      chef_run = ChefSpec::Runner.new(options)
    end
  end
end

module ChefSpecStubHelpers
  def stub_data_bag(args, retval)
    Chef::Recipe.any_instance.stub(:data_bag_item).and_return(Hash.new)
    if args.is_a? Array
      Chef::Recipe.any_instance.stub(:data_bag_item).with(*args).and_return(retval) # Call with asterisk to pass args array as separate args to '#with'
    else
      Chef::Recipe.any_instance.stub(:data_bag_item).with(args).and_return(retval)
    end
  end

  def stub_encrypted_data_bag(args, retval)
    Chef::Recipe.any_instance.stub(:encrypted_data_bag_item).and_return(Hash.new) if :encrypted_data_bag_item.nil?
    Chef::Recipe.any_instance.stub(:encrypted_data_bag_item).with(*args).and_return(retval)
  end

  def stub_search(args, retval)
    Chef::Recipe.any_instance.stub(:search).with(*args).and_return(retval)
  end
end

class String
  def strip_heredoc
    indent = scan(/^[ \t]*(?=\S)/).min.try(:size) || 0
    gsub(/^[ \t]{#{indent}}/, '')
  end
end

# Just a simple printf helper method
def debug_output(name, value)
  format_str = "%-24s: %s\n"
  printf format_str, name, value
end

# Make ChefSpecHelpers available within all 'describe' blocks
# Make ChefSpecStubHelpers available within all 'it' blocks and 'let' blocks
# https://www.relishapp.com/rspec/rspec-core/docs/helper-methods/define-helper-methods-in-a-module
RSpec.configure do |c|
  c.extend ChefSpecHelpers
  c.include ChefSpecStubHelpers
  c.include ChefSpecHelpers # allow use of create_chefspec_runner in 'let' block
end
