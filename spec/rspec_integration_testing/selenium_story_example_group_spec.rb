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

      example.should_not have_failed
    end

    it "supports a session for each example in a group" do
      example_group = Class.new(SeleniumStoryExampleGroup)
      example_group.scenario "I can see my session info when I log in" do
        Given :i_log_in
        When  :i_am_sent_back_to_the_home_page
        Then  :i_see_session_info
      end
      example_group.scenario "I can't see the session info from the last example" do
        Given :i_am_a_guest_user
        When  :i_am_on_the_home_page
        Then  :i_dont_see_the_session_info_of_the_last_user
      end

      example_group.class_eval do
        class << self
          attr_accessor :login
        end
        def login; self.class.login end
      end
      example_group.login = "joeschmoe"

      example_group.class_eval do
        def i_log_in
          open "/"
          type "id=login", login
          click "id=submit_login"
        end
        def i_am_sent_back_to_the_home_page
          wait_for_page_to_load
          wait_for_text "Whazzup!?"
        end
        def i_see_session_info
          wait_for_text login
        end
        def i_am_a_guest_user; end
        def i_am_on_the_home_page
          open "/"
        end
        def i_dont_see_the_session_info_of_the_last_user
          text?(login).should be_false
        end
      end

      example_group.run(@options)

      example.should_not have_failed
    end

    it "deletes all cookies between each example" do
      example_group = Class.new(SeleniumStoryExampleGroup)
      example_group.scenario "I do something that creates cookies" do
        Given :i_create_a_bunch_of_cookies
      end
      example_group.scenario "I have no cookies :(" do
        Then  :i_have_no_cookies
      end

      example_group.class_eval do
        def i_create_a_bunch_of_cookies
          create_cookie "a=1"
          create_cookie "b=2"
          cookies.should == 'a=1; b=2'
        end
        def i_have_no_cookies
          cookies.should == ""
        end
      end

      example_group.run(@options)

      example.should_not have_failed
    end

    def report_on_failed_example
      if example.failed?
        p example.exception
        puts example.exception.backtrace.join("\n")
      end
    end
  end
end
