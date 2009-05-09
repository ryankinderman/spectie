require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "spec/runner/formatter/base_formatter"

class TestingFormatter < Spec::Runner::Formatter::BaseFormatter
  def initialize(options, output, example_state)
    @example_state = example_state
  end

  def example_failed(example_proxy, counter, failure)
    @example_state.failed!(failure)
  end
end

class ExampleState
  attr_reader :exception
  def failed?
    !exception.nil?
  end
  def failed!(failure)
    @exception = failure.exception
  end
end

def prevent_reporting_run_results_for_examples_being_tested
  before(:each) do
    @original_rspec_options = ::Spec::Runner.options
    @options = ::Spec::Runner::Options.new(StringIO.new, @error_stream = StringIO.new)
    @example_state = ExampleState.new
    @formatter = TestingFormatter.new(@options, @error_stream, @example_state)
    class << self
      def example
        @example_state
      end
    end
    @options.formatters << @formatter
    ::Spec::Runner.use(@options)
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

      it "supports 'scenario' method for creating an example" do
        example_group = Class.new(RailsExampleGroup)
        example_ran_as_scenario = false

        example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
          example_ran_as_scenario = true
        end
        example_group.run(@options)

        example_ran_as_scenario.should be_true
      end

      [:Given, :When, :Then].each do |scenario_statement_prefix|
        it "can use #{scenario_statement_prefix} to call dsl methods from within the scenario" do
          example_group = Class.new(RailsExampleGroup) do
            class << self
              attr_accessor :scenario_statement_was_executed
            end
          end

          example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
            send scenario_statement_prefix, :i_am_executed
          end

          dsl = example_group.dsl do
            def i_am_executed
              self.class.scenario_statement_was_executed = true
            end
          end
          example_group.run(@options)

          example_group.scenario_statement_was_executed.should be_true
        end
      end

      it "has access to the dsl methods defined on a parent example group" do
        parent_example_group = Class.new(RailsExampleGroup) do
          class << self
            attr_accessor :scenario_statement_was_executed
          end
        end
        parent_example_group.dsl do
          def i_am_executed
            self.class.scenario_statement_was_executed = true
          end
        end
        example_group = Class.new(parent_example_group)

        example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
          Given :i_am_executed
        end
        example_group.run(@options)

        example_group.scenario_statement_was_executed.should be_true
      end

      it "can override the definition of a dsl method on a parent example group" do
        parent_example_group = Class.new(RailsExampleGroup) do
          class << self
            attr_accessor :scenario_statement_was_executed
          end
        end
        parent_example_group.dsl do
          def i_am_executed
            self.class.scenario_statement_was_executed = "parent"
          end
        end
        example_group = Class.new(parent_example_group)
        example_group.dsl do
          def i_am_executed
            self.class.scenario_statement_was_executed = "child"
          end
        end

        example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
          Given :i_am_executed
        end
        example_group.run(@options)

        example_group.scenario_statement_was_executed.should == "child"
      end

      xit "cannot call a dsl method without Given" do
        example_group = Class.new(RailsExampleGroup)
        example_group.class_eval do
          class << self
            attr_accessor :given_was_executed
          end
        end

        example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
          i_am_executed
        end

        dsl = example_group.dsl do
          def i_am_executed
            self.class.given_was_executed = true
          end
        end
        example_group.run(@options)

        example.should be_failed
        example.exception.should === NoMethodError
        example_group.given_was_executed.should be_false
      end

    end

  end

end
