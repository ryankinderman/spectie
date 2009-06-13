require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/../../vendor/rails/actionpack/lib/action_controller")

class TestsController < ActionController::Base
end

module RspecIntegrationTesting
  describe "Rails Stories" do

    prevent_reporting_run_results_for_examples_being_tested

    it "can make a controller request and inspect the response" do
      example_group = Class.new(StoryExampleGroup)
      example_group.scenario %[
        As an interested user of a web site running on Rails,
        I want to check out the homepage] do

      end
    end

  end
end
