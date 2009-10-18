require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Spectie" do

  track_example_run_state

  it "can be registered as an example group that gets returned as a named type" do
    example_group = create_story_example_group(:some_type)
    created_example_group = Spec::Example::ExampleGroupFactory.create_example_group(:type => :some_type) {}
    created_example_group.superclass.should == example_group
  end

  it "creates an example group when Feature is called" do
    example_group = create_story_example_group(:some_type)
    example_group.send :class_variable_set, :@@scenario_called, false

    Feature "User Authentication", :type => :some_type do
      Scenario "A user can create an account to authenticate with" do
        Given :i_do_not_have_an_account
        When  :i_create_an_account
        Then  :i_can_authenticate
      end

      def i_do_not_have_an_account
      end
      def i_create_an_account
      end
      def i_can_authenticate
        self.class.send :class_variable_set, :@@scenario_called, true
      end
    end

    @options.run_examples

    example.should_not have_failed
    example_group.send(:class_variable_get, :@@scenario_called).should be_true
  end


  def create_story_example_group(type_name)
    example_group = Class.new { include Spectie::StoryExampleGroupMethods }
    Spec::Example::ExampleGroupFactory.register(type_name, example_group)
    example_group
  end

end
