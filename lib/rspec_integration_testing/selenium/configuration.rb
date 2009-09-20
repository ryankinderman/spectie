module RspecIntegrationTesting
  module Configuration
    class Selenium
      attr_writer :driver_options
      attr_accessor :browser_reset_instead_of_restart, :controlled

      def initialize
        self.browser_reset_instead_of_restart = true
        self.controlled = true
      end

      def driver_options
        @driver_options || raise("No Selenium driver options specified")
      end

      def controlled?
        self.controlled == true
      end

    end

    def selenium
      @selenium ||= Selenium.new
    end
  end
  ::Spec::Runner.send :include, Configuration
end
