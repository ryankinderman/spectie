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
require "spec/rails"

ActionController::IntegrationTest.class_eval do
  alias_method :orig_initialize, :initialize
  def initialize(*args)
    super
  end
end

module Spectie

  class RailsStoryExampleGroup < ActionController::IntegrationTest
    include StoryExampleGroupMethods

    # The following line ensures that RailsStoryExampleGroup is, by 
    # default, the lowest point in the example group hierarchy that 
    # helper modules will be included.
    #
    # If that doesn't make sense, just comment this line
    # out and observe the failing test.
    Spec::Example::ExampleGroupFactory.default(self)
    Spec::Example::ExampleGroupFactory.register(:integration, self)
  end

end

