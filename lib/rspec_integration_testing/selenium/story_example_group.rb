begin
  selenium_client_path = "selenium/client" 
  require selenium_client_path
rescue LoadError => e
  if e.message =~ /#{Regexp.escape(selenium_client_path)}$/
    raise "selenium-client not available. Install it with sudo gem install selenium-client"
  else
    raise e
  end
end

module RspecIntegrationTesting
  class SeleniumStoryExampleGroup
    include StoryExampleGroupMethods
    include Selenium::Client::SeleniumHelper

    before :all do
      # TODO: make this configurable
      @selenium = Selenium::Client::Driver.new(Spec::Runner.configuration.selenium.driver_options)
      @selenium.start
    end

    after :all do
      @selenium.stop
    end

    before :each do
      # initialize browser for next session without needing to restart browser
      # TODO: make this an option
      @selenium.open("/")
      @selenium.delete_all_visible_cookies
    end
  end
end
