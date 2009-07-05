require "rspec_integration_testing/story_example_group_methods"
###################################################################################
# Preserve method_missing from rspec, which supports the general 
# be_ and have_ predicate matchers. This method gets overridden for
# Rails integration tests by ActionController::IntegrationTest for
# session delegation.
require "spec/interop/test/unit/testcase"
Test::Unit::TestCase.class_eval do 
  alias_method :method_missing_from_rspec, :method_missing
end

require "action_controller/integration"
ActionController::IntegrationTest.class_eval do
  alias_method :method_missing_from_rails, :method_missing
  def method_missing(*args, &block)
    method_missing_from_rspec(*args, &block)
  rescue NameError
    method_missing_from_rails(*args, &block)
  end
end
###################################################################################
begin
  require "spec/rails"
rescue LoadError
  raise "RSpec-Rails not available. Install it with sudo gem install rspec-rails"
end

require "rspec_integration_testing/rails_story_example_group"

