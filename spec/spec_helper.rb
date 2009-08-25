Spec::Runner.configure do |config|
  config.mock_with :mocha
end
require File.expand_path(File.dirname(__FILE__) + "/example_run_state_tracking")

require File.expand_path(File.dirname(__FILE__) + "/../initialize")

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec_integration_testing'

