require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

class TestsController < ApplicationController
  def index; render :nothing => true end
end
# Not sure why the following line needs to exist, I would think it'd just use the default routes from routes.rb,
# but apparently not. Need to figure out why, but not now.
ActionController::Routing::Routes.add_route "/tests/:action", :controller => "tests"

module RspecIntegrationTesting
  describe "Rails Stories" do

    prevent_reporting_run_results_for_examples_being_tested

    it "can make a controller request and inspect the response" do
      example_group = Class.new(RailsStoryExampleGroup)
      example_group.scenario "Make a request to a controller" do
        Given :i_want_to_test_an_integration_test_with_rails
        When  :i_make_a_controller_request
        Then  :i_can_assert_the_response
      end
      
      example_group.dsl do
        def i_want_to_test_an_integration_test_with_rails; end
        
        def i_make_a_controller_request
          get "/tests"
        end

        def i_can_assert_the_response
          response.should be_success
        end
      end

      example_group.run(@options)

      example.should_not be_failed
    end

  end
end
