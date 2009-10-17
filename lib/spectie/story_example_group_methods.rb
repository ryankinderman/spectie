module Spectie

  module StoryExampleGroupMethods
    def self.included(mod)
      mod.class_eval do 
        extend Spec::Example::ExampleGroupMethods
        include Spec::Example::ExampleMethods

        class << self

          def scenario_methods; [:Given, :When, :Then, :And] end

          def dsl(&implementation)
            class_eval &implementation
          end

          def Scenario(description, options={}, backtrace=nil, &implementation)
            example(description, options, backtrace) do
              instance_eval &implementation
            end
          end

          def xScenario(description, options={}, &implementation)
            xexample description, options, &implementation
          end

        end

        scenario_methods.each do |scenario_method|
          method = <<-METHOD
          def #{scenario_method}(statement, *args, &block)
            send statement, *args, &block
          end
          METHOD

          class_eval method, __FILE__, __LINE__
        end

      end
    end
  end
end
