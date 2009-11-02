module Spectie
  module Selenium
    module Configuration
      class Attributes
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
        @selenium ||= Attributes.new
      end
    end
    ::Spec::Runner::Configuration.send :include, Configuration
  end
end
