require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

module Spectie
  module Configuration
    describe Selenium do
      it "creates a configuration the first time it's accessed" do
        Spec::Runner.configuration.selenium.should_not be_nil
        Spec::Runner.configuration.selenium.class.should == Selenium
      end
      
      it "provides driver options" do
        config = Selenium.new
        config.driver_options = "blah"
        config.driver_options.should == "blah"
      end

      it "raises an error if driver options are not set before they're accessed" do
        config = Selenium.new
        lambda { config.driver_options }.should raise_error
      end

      describe "affect on example group runs" do
        track_example_run_state

        it "only starts the driver once for multiple example groups if browser reset instead of restart is enabled" do
          @original_value = Spec::Runner.configuration.selenium.start_browser_once
          begin
            start_call_count = 0
            ::Selenium::Client::Driver.stubs(:new).
              returns(mock_driver = stub_everything("mock selenium driver"))
            mock_driver.stubs(:start).with { start_call_count += 1; true }
              
            Spec::Runner.configuration.selenium.start_browser_once = true

            example_group1 = Class.new(SeleniumStoryExampleGroup)
            example_group1.class_eval do
              def teardown_mocks_for_rspec
                # do nothing so that the mock persists through to the second example group
              end
            end
            example_group1.Scenario "The selenium driver is started once" do
              start_call_count.should == 1
            end
            example_group2 = Class.new(SeleniumStoryExampleGroup)
            example_group2.Scenario "The selenium driver is still started once" do
              start_call_count.should == 1
            end

            with_selenium_control { @options.run_examples }
            example.should_not have_failed
          ensure
            Spec::Runner.configuration.selenium.start_browser_once = @original_value
          end
        end

        it "starts the driver for each example if browser reset instead of restart is disabled" do
          @original_value = Spec::Runner.configuration.selenium.start_browser_once
          begin
            start_call_count = 0
            ::Selenium::Client::Driver.stubs(:new).
              returns(mock_driver = stub_everything("mock selenium driver"))
            mock_driver.stubs(:start).with { start_call_count += 1; true }

            Spec::Runner.configuration.selenium.start_browser_once = false

            example_group1 = Class.new(SeleniumStoryExampleGroup)
            example_group1.class_eval do
              def teardown_mocks_for_rspec
                # do nothing so that the mock persists through to the second example group
              end
            end
            example_group1.Scenario "The selenium driver is started once" do
              start_call_count.should == 1
            end
            example_group2 = Class.new(SeleniumStoryExampleGroup)
            example_group2.Scenario "The selenium driver is started twice" do
              start_call_count.should == 2
            end
            
            with_selenium_control { @options.run_examples }
            example.should_not have_failed
          ensure
            Spec::Runner.configuration.selenium.start_browser_once = @original_value
          end
        end

      end

    end
  end
end
