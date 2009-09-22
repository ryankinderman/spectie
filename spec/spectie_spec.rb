require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Spectie" do

  it "can be registered as an example group that gets returned as a named type" do
    example_group = Class.new { include Spectie::StoryExampleGroupMethods }
    Spec::Example::ExampleGroupFactory.register(:some_type, example_group)
    created_example_group = Spec::Example::ExampleGroupFactory.create_example_group(:type => :some_type) {}
    created_example_group.superclass.should == example_group
  end

end
