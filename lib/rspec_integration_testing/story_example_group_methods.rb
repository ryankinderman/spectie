module RspecIntegrationTesting

  class ScenarioStatementOrderError < StandardError; end
  
  module StoryExampleGroupMethods
    def self.included(mod)
      mod.class_eval do 
        extend Spec::Example::ExampleGroupMethods
        include Spec::Example::ExampleMethods

        class << self
          def scenario_methods; [:Given, :When, :Then, :And] end
        end

        [:Given, :When, :Then, :And].each do |scenario_method|
          method = <<-METHOD
            def #{scenario_method}(statement, *args, &block)
          METHOD
          if scenario_method == :And
            method += <<-METHOD
              raise ScenarioStatementOrderError, "Cannot start a scenario with 'And'" if @last_scenario_method_called.nil?
            METHOD
          end
          method += <<-METHOD
            send statement, *args, &block
            @last_scenario_method_called = #{scenario_method.inspect}
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
