class RspecRailsIntegrationExampleGroup
  extend Spec::Example::ExampleGroupMethods
  include Spec::Example::ExampleMethods

  Spec::Example::ExampleGroupFactory.register(:integration, self)
end
