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

class HaveFailed
  def matches?(example)
    @example = example
    example.failed?
  end

  def description
    "have failed"
  end

  def failure_message_for_should_not
    "expected example not to fail, but it did with:\n  Message: #{@example.exception.message}\n  Backtrace:\n  #{@example.exception.backtrace.join("\n  ")}"
  end
end

Spec::Example::ExampleGroupMethods.module_eval do
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
        def have_failed
          HaveFailed.new
        end
      end
      @options.formatters << @formatter
      ::Spec::Runner.use(@options)
    end

    after(:each) do
      ::Spec::Runner.use(@original_rspec_options)
    end
  end
end

