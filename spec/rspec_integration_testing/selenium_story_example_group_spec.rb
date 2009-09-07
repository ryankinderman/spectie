require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/../selenium_helper")
require "rspec_integration_testing/selenium_story_example_group"

module RspecIntegrationTesting
  describe "Selenium Stories" do

    track_example_run_state

    it "can open a path, inspect response, and interact with elements" do
      example_group = Class.new(SeleniumStoryExampleGroup)
      example_group.scenario "Open a page and click on a link" do
        Given :i_am_on_a_page_with_a_link
        When  :i_click_a_link
        Then  :i_go_to_the_destination
      end

      example_group.class_eval do
        def i_am_on_a_page_with_a_link
          open "/"
          wait_for_text "Whazzup!?"
        end
        def i_click_a_link
          wait_for_element "link=Click me"
          click "link=Click me"
        end
        def i_go_to_the_destination
          wait_for_text "Booyah!"
        end
      end

      example_group.run(@options)

      if example.failed?
        p example.exception
        puts example.exception.backtrace.join("\n")
      end
      example.should_not be_failed
    end

  end
end
