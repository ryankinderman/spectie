require File.expand_path(File.dirname(__FILE__) + "/rails_helper")

class TestsController < ApplicationController
  def index; render :text => "<p>Hello there!</p>" end
end
# Not sure why the following line needs to exist, I would think it'd just use the default routes from routes.rb,
# but apparently not. Need to figure out why, but not now.
ActionController::Routing::Routes.add_route "/tests/:action", :controller => "tests"

module Spectie
  describe "Rails Stories" do

    track_example_run_state

    it "is registered by default for the 'integration' behavior type" do
      created_example_group = Spec::Example::ExampleGroupFactory.create_example_group(:type => :integration) {}
      created_example_group.superclass.should == RailsStoryExampleGroup
    end

    it "can include a helper module that defines method_missing" do
      (example_group = Class.new(RailsStoryExampleGroup)).class_eval do
        scenario "I'm going to call a method that doesn't exist in the integration session" do
          i_dont_exist_in_the_integration_session
        end
      end

      @options.run_examples

      example.should_not have_failed
    end

    it "can make a controller request and inspect the response" do
      example_group = Class.new(RailsStoryExampleGroup)
      example_group.scenario "Make a request to a controller" do
        Given :i_want_to_write_an_integration_test_for_rails
        When  :i_make_a_controller_request
        Then  :i_can_assert_the_response
      end
      
      example_group.class_eval do
        def i_want_to_write_an_integration_test_for_rails; end
        
        def i_make_a_controller_request
          get "/tests"
        end

        def i_can_assert_the_response
          response.should be_success
          response.should have_tag("p", "Hello there!")
        end
      end

      example_group.run(@options)

      example.should_not be_failed
    end

  end
end
