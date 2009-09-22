module Spectie
  module Configuration
    class ForScenarios
    end
    def scenarios
      ForScenarios.new
    end
  end
  ::Spec::Runner::Configuration.send :include, Configuration
end
