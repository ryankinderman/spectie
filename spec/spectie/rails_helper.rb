require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

Dir[File.expand_path(File.dirname(__FILE__) + "/../../vendor/rails/*/lib")].each do |rails_lib|
  $:.unshift rails_lib
end

ENV["RAILS_ENV"] = "test"
$:.unshift File.expand_path(File.dirname(__FILE__) + "/../support/rails_app/controllers")

require "initializer"
require "action_controller"

ActionController::Base.session = {:key => "_myapp_session", :secret => "a"*30}

require "spectie/rails_story_example_group"

module HelperToTestRailsIntegration
  def method_missing(method, *args, &block)
    if method.to_sym == :i_dont_exist_in_the_integration_session
      # handled here
    else
      super
    end
  end
end

Spec::Runner.configure do |config|
  config.include HelperToTestRailsIntegration
end
