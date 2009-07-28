module RspecIntegrationTesting
  
  class Scenario
    class << self
      def scenario_methods; [:Given, :When, :Then, :And] end
      attr_accessor :strict
    end
    self.strict = false

    def initialize(example)
      @example = example
    end

    scenario_methods.each do |scenario_method|
      class_eval <<-METHOD
      def #{scenario_method}(statement, *args, &block)
        @example.send statement, *args, &block
      end
      METHOD
    end
  end

  module StoryExampleGroupMethods
    def self.included(mod)
      mod.class_eval do 
        extend Spec::Example::ExampleGroupMethods
        include Spec::Example::ExampleMethods

        class << self

          def dsl(&implementation)
            class_eval &implementation
          end

          def scenario(description, options={}, backtrace=nil, &implementation)
            example(description, options, backtrace) do
              Scenario.new(self).instance_eval &implementation
            end
          end

          def xscenario(description, options={}, &implementation)
            xexample description, options, &implementation
          end

        end

      end
    end
  end
end
