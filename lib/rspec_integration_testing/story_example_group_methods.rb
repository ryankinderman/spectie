module RspecIntegrationTesting
  
  module StoryExampleGroupMethods
    def self.included(mod)
      mod.class_eval do 
        extend Spec::Example::ExampleGroupMethods
        include Spec::Example::ExampleMethods

        class << self
          def scenario_methods; [:Given, :When, :Then, :And] end
          attr_accessor :strict
        end
        self.strict = false

        scenario_methods.each do |scenario_method|
          method = <<-METHOD
          def #{scenario_method}(statement, *args, &block)
            send statement, *args, &block
          end
          METHOD
          class_eval method, __FILE__, __LINE__
        end

        class << self

          def dsl(&implementation)
            class_eval &implementation
          end

          def scenario(description, options={}, backtrace=nil, &implementation)
            example(description, options, backtrace) do
              instance_eval &implementation
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
