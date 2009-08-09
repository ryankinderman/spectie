require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

module RspecIntegrationTesting

  class StoryExampleGroup
    include StoryExampleGroupMethods
  end

  describe StoryExampleGroup do

    track_example_run_state

    it "supports 'xscenario' method for disabling an example" do
      example_group = Class.new(StoryExampleGroup)
      example_ran_as_scenario = false
      Kernel.expects(:warn).with { |message| message =~ /^Example disabled/  }

      example_group.xscenario "As a user, I want to make a series of requests for our mutual benefit" do
        example_ran_as_scenario = true
      end
      example_group.run(@options)

      example_ran_as_scenario.should be_false
    end

    it "supports pending scenarios" do
      example_group = Class.new(StoryExampleGroup)
      example_group.scenario "As a user, I want to make a series of requests for our mutual benefit"
      @options.reporter.expects(:example_finished).with(anything, ::Spec::Example::ExamplePendingError)

      example_group.run(@options)
    end

    it "supports 'scenario' method for creating an example" do
      example_group = Class.new(StoryExampleGroup)
      example_ran_as_scenario = false

      example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
        example_ran_as_scenario = true
      end
      example_group.run(@options)

      example_ran_as_scenario.should be_true
    end

    [:Given, :When, :Then, :And].each do |scenario_method|
      it "can use #{scenario_method} to call scenario statements from within the scenario" do
        example_group = Class.new(StoryExampleGroup) do
          class << self
            attr_accessor :scenario_statement_was_executed
          end
        end

        example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
          send scenario_method, :i_am_executed
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

    it "has access to the scenario statements defined on a parent example group" do
      parent_example_group = Class.new(StoryExampleGroup) do
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

    it "can override the definition of a scenario statement on a parent example group" do
      parent_example_group = Class.new(StoryExampleGroup) do
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

    it "supports scenario statement nesting" do
      example_group = Class.new(StoryExampleGroup)
      example_group.class_eval do
        class << self
          attr_accessor :nested_statement_was_executed
        end
      end
      example_group.scenario "As a tester, I want to be able to write nested dsl statements" do
        Given :this_statement_takes_a_block do 
          Then :i_can_nest_a_statement
        end
      end
      example_group.dsl do 
        def this_statement_takes_a_block
          yield
        end
        def i_can_nest_a_statement
          self.class.nested_statement_was_executed = true
        end
      end

      example_group.run(@options)

      example.should_not be_failed
      example_group.nested_statement_was_executed.should be_true
    end

    xit "handles scenario statements that start with 'should'" do
      # This example doesn't quite describe the issue. For some reason,
      # RSpec treates methods inside an example group that start with 
      # 'should' differently, and counts them as examples. Need to 
      # figure out why before going any futher w/this.
      example_group = Class.new(StoryExampleGroup)
      example_group.class_eval do 
        class << self
          attr_accessor :called_the_method
        end
      end
      example_group.scenario "As a tester, I want to start a scenario statement with 'should'" do
        Given :this_statement_calls_a_method_starting_with_should
      end
      example_group.dsl do 
        def this_statement_calls_a_method_starting_with_should
          should_do_something
        end
        def should_do_something
          self.class.called_the_method = true
          1.should == 1
        end
      end

      example_group.run(@options)

      example_group.called_the_method.should be_true
      example.should_not be_failed
    end

    it "shares state between the scenario and the scenario statements" do
      example_group = Class.new(StoryExampleGroup)

      example_group.scenario "As a user, I want to make a series of requests for our mutual benefit" do
        Given :the_example_has_state
        @state.should == 1
        @state = 2
        Then  :the_state_is_shared
      end

      dsl = example_group.dsl do
        def the_example_has_state
          @state = 1
        end
        def the_state_is_shared
          @state.should == 2
        end
      end
      example_group.run(@options)

      example.should_not be_failed
    end

  end
end
