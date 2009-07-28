module RspecIntegrationTesting

  class ScenarioStatementOrderError < StandardError; end
  
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

          def scenario(description, options={}, backtrace=nil, &implementation)
            example(description, options, backtrace) do
              instance_eval &implementation
            end
          end

          def xscenario(description, options={}, &implementation)
            xexample description, options, &implementation
          end

          def ordered_scenario_methods; [:Given, :When, :Then]; end
          def unordered_scenario_methods; [:And]; end
          def scenario_methods; ordered_scenario_methods + unordered_scenario_methods; end

        end

        def strict?
          Spec::Runner.configuration.scenarios.strict
        end

        scenario_methods.each do |scenario_method|
          method = <<-METHOD
            def #{scenario_method}(statement, *args, &block)
          METHOD
          if scenario_method == :And
            method += <<-METHOD
              raise ScenarioStatementOrderError, "Cannot start a scenario with 'And'" if strict? and @last_scenario_method_called.nil?
            METHOD
          else
            method += <<-METHOD
              ordered_methods = self.class.ordered_scenario_methods
              if strict? and !@last_scenario_method_called.nil?
                current_method_ordinal = ordered_methods.index(#{scenario_method.inspect})
                last_method_ordinal = ordered_methods.index(@last_scenario_method_called)
                called_out_of_order = current_method_ordinal < last_method_ordinal
                raise ScenarioStatementOrderError, "Cannot provide a '#{scenario_method}' statement after a '\#{@last_scenario_method_called}' statement" if called_out_of_order
              end
            METHOD
          end
          method += <<-METHOD
            send statement, *args, &block
          METHOD
          unless scenario_method == :And
            method += <<-METHOD
              @last_scenario_method_called = #{scenario_method.inspect}
            METHOD
          end
          method += <<-METHOD
          end
          METHOD

          class_eval method, __FILE__, __LINE__
        end

      end
    end
  end
end
