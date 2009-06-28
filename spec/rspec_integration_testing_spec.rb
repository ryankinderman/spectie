require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RspecIntegrationTesting" do

  # this should be wrapped in a method that's optionally called
  xit "returns the custom integration-testing example group from 'integration' type" do
    example_group = Spec::Example::ExampleGroupFactory.create_example_group(:type => :integration) {}
    example_group.superclass.should == RspecIntegrationTesting::StoryExampleGroup
  end

end
