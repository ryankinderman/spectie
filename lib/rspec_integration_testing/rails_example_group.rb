module RspecIntegrationTesting
  class RailsExampleGroup < Spec::Example::ExampleGroup

    class << self

      def scenario(description, options={}, backtrace=nil, &implementation)
        example(description, options={}, backtrace=nil, &implementation)
      end

    end

    Spec::Example::ExampleGroupFactory.register(:integration, self)
  end
end
