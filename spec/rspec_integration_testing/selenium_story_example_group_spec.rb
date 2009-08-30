require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/../selenium_helper")
require "rspec_integration_testing/selenium_story_example_group"

module RspecIntegrationTesting
  describe "Selenium Stories" do

    track_example_run_state

    it "can open a path, inspect response, and interact with elements" do
      example_group = Class.new(SeleniumStoryExampleGroup)
      example_group.scenario "Open a path, inspect response, and click a link" do
        Given :i_am_on_the_homepage
        When  :i_click_the_link_to_have_some_fun
        Then  :i_see_where_to_put_the_fun
      end

      example_group.class_eval do
        def i_am_on_the_homepage
          open "/"
        end
      end

#      example_group.run(@options)
#
#      p example.exception
#      puts example.exception.backtrace.join("\n")
#      example.should_not be_failed
    end

  end
end
