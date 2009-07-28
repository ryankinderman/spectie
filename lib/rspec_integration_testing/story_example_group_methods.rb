module RspecIntegrationTesting
  
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
              instance_eval &implementation
            end
          end

          def xscenario(description, options={}, &implementation)
            xexample description, options, &implementation
          end

        end

        [:Given, :When, :Then].each do |scenario_method|
          class_eval <<-METHOD
          def #{scenario_method}(statement, *args, &block)
            send statement, *args, &block
          end
          METHOD
        end
      end
    end
  end
end
