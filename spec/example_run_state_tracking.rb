require "spec/runner/formatter/base_formatter"

class TestingFormatter < Spec::Runner::Formatter::BaseFormatter
  def initialize(options, output, example_state)
    @example_state = example_state
  end

  def example_failed(example_proxy, counter, failure)
    @example_state.failed!(failure)
  end
end

class ExampleState
  attr_reader :exception
  def failed?
    !exception.nil?
  end
  def failed!(failure)
    @exception = failure.exception
  end
end

def track_example_run_state
  before(:each) do
    @original_rspec_options = ::Spec::Runner.options
    @options = ::Spec::Runner::Options.new(StringIO.new, @error_stream = StringIO.new)
    @example_state = ExampleState.new
    @formatter = TestingFormatter.new(@options, @error_stream, @example_state)
    class << self
      def example
        @example_state
      end
    end
    @options.formatters << @formatter
    ::Spec::Runner.use(@options)
  end

  after(:each) do
    ::Spec::Runner.use(@original_rspec_options)
  end
end
