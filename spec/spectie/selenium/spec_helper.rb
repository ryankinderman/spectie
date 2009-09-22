require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "spectie/selenium"
require File.expand_path(File.dirname(__FILE__) + "/../../selenium_config")

module SeleniumStoryExampleGroupTestingHelper
  def with_selenium_control
    Spec::Runner.configuration.selenium.controlled = true
    yield
  ensure
    Spec::Runner.configuration.selenium.controlled = false
  end
end

Spec::Runner.configure do |config|
  config.include(SeleniumStoryExampleGroupTestingHelper)
end
