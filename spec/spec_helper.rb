require 'cookbook/development/test/unit/chefspec'
require 'support/chefspec_helpers'
require 'support/chefspec_matchers'

$:.unshift File.join( File.dirname(__FILE__), '..', 'libraries')

module ChefSpecHelpers
  TOPDIR = File.expand_path(File.join(File.dirname(__FILE__), ".."))
  COOKBOOK_PATH = File.join TOPDIR, 'vendor', 'cookbooks'
end
