module RspecIntegrationTesting
  module Configuration
    class Selenium
      attr_writer :driver_options

      def driver_options
        @driver_options || raise("No Selenium driver options specified")
      end
    end

    def selenium
      @selenium ||= Selenium.new
    end
  end
  ::Spec::Runner.send :include, Configuration
end
