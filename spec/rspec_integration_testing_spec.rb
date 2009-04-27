require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RspecIntegrationTesting" do

  it "returns the custom integration-testing example group from 'integration' type" do
    example_group = Spec::Example::ExampleGroupFactory.create_example_group(:type => :integration) {}
    example_group.superclass.should == RspecRailsIntegrationExampleGroup
  end

end
