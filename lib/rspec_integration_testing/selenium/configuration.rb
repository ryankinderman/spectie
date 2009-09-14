module RspecIntegrationTesting
  module Configuration
    class Selenium
      attr_accessor :driver_options

      def initialize
        self.driver_options = {
          :host => "10.211.55.127",
          :port => 4444,
          :browser => "*firefox",
          :timeout_in_seconds => 10,
          :url => "http://10.211.55.1:4567"
        }
      end
    end

    def selenium
      @selenium ||= Selenium.new
    end
  end
  ::Spec::Runner.send :include, Configuration
end
