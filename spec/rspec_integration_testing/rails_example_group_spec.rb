require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

module RspecIntegrationTesting

  describe RailsExampleGroup do

    it "is a subclass of RSpec's ExampleGroup" do
      RspecIntegrationTesting::RailsExampleGroup.superclass.should == Spec::Example::ExampleGroup
    end

    it "supports 'scenario' keyword for creating an example" do
      example_group = Class.new(RailsExampleGroup)
      example_ran_as_scenario = false
      example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
        example_ran_as_scenario = true
      end

      example_group.run(::Spec::Runner::Options.new(StringIO.new, StringIO.new))

      example_ran_as_scenario.should be_true
    end

  end


  class ExampleSupportsScenarios < RailsExampleGroup
    describe RailsExampleGroup, "supporting scenarios"

    scenario "As a user of a system, I would like to make a series of requests against your system" do
    end

  end

end
