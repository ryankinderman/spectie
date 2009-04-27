require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

def prevent_reporting_run_results_for_examples_being_tested
  before(:each) do
    @original_rspec_options = ::Spec::Runner.options
    ::Spec::Runner.use(@options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new))
  end

  after(:each) do
    ::Spec::Runner.use(@original_rspec_options)
  end
end

module RspecIntegrationTesting

  describe RailsExampleGroup do

    it "is a subclass of RSpec's ExampleGroup" do
      RspecIntegrationTesting::RailsExampleGroup.superclass.should == Spec::Example::ExampleGroup
    end

    describe "#run with scenarios" do

      prevent_reporting_run_results_for_examples_being_tested

      it "supports 'scenario' method for creating an example" do
        example_group = Class.new(RailsExampleGroup)
        example_ran_as_scenario = false
        example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
          example_ran_as_scenario = true
        end

        example_group.run(@options)

        example_ran_as_scenario.should be_true
      end

      it "supports 'xscenario' method for disabling an example" do
        example_group = Class.new(RailsExampleGroup)
        example_ran_as_scenario = false
        Kernel.expects(:warn).with { |message| message =~ /^Example disabled/  }
        example_group.xscenario "As a user, I want to make a series of requests for our mutual benefit" do
          example_ran_as_scenario = true
        end

        example_group.run(@options)

        example_ran_as_scenario.should be_false
      end

      it "supports pending scenarios" do
        example_group = Class.new(RailsExampleGroup)
        example_group.scenario "As a user, I want to make a series of requests for our mutual benefit"
        @options.reporter.expects(:example_finished).with(anything, ::Spec::Example::ExamplePendingError)

        example_group.run(@options)
      end

    end

  end


  class ExampleSupportsScenarios < RailsExampleGroup
    describe RailsExampleGroup, "supporting scenarios"

    scenario "As a user of a system, I would like to make a series of requests against your system" do
    end

  end

end
