require File.expand_path(File.dirname(__FILE__) + "/../initialize")

begin
  require 'spec'
rescue LoadError
  raise "RSpec not available. Install it with: sudo gem install rspec"
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec_integration_testing'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
