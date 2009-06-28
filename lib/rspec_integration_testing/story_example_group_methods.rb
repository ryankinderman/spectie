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

        [:Given, :When, :Then].each do |scenario_statement_prefix|
          define_method scenario_statement_prefix do |dsl_method, *args|
            send dsl_method, *args
          end
        end
      end
    end
  end
#   class StoryExampleGroup < Spec::Example::ExampleGroup

#     class << self

#       def dsl(&implementation)
#         class_eval &implementation
#       end

#       def scenario(description, options={}, backtrace=nil, &implementation)
#         example(description, options, backtrace) do
#           instance_eval &implementation
#         end
#       end

#       def xscenario(description, options={}, &implementation)
#         xexample description, options, &implementation
#       end

#     end

#     [:Given, :When, :Then].each do |scenario_statement_prefix|
#       define_method scenario_statement_prefix do |dsl_method, *args|
#         send dsl_method, *args
#       end
#     end

#   end
end
