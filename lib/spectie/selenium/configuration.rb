module Spectie
  module Configuration
    class Selenium
      attr_writer :driver_options
      attr_accessor :start_browser_once, :controlled

      def initialize
        self.start_browser_once = true
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
