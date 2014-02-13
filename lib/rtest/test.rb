module RTest
  class Test

    FAIL = "FAILED"

    attr_reader :expectations

    def initialize(message = nil, &block)
      @message = message
      @expectations = []
      instance_eval(&block) if block_given?
    end

    def expect(object)
      expectation = Expect.new(object)
      @expectations << expectation
      expectation
    end

    def equal(object)
      Equal.new(object)
    end

    def run
      unless(empty_test?)
        run_test_result
      end
    end

    private
    def console
      Console.instance
    end

    def run_test_result
      begin
        run_expectations
        console.display_leveled_message(1, success_message, :green)
      rescue TestFailureError => error
        error_message(error)
      end
    end

    def error_message(error)
      console.display_leveled_message(1, failure_message, :red)
      console.display_leveled_message(2, error.message, :red)
    end

    def run_expectations
      @expectations.each do |expectation| 
        raise TestFailureError, expectation.failure_message unless expectation.pass?
      end
    end

    def empty_test?
      @expectations.size == 0
    end

    def success_message
      @message || first_expectation_message
    end

    def failure_message
      @message || FAIL
    end

    def first_expectation_message
      @expectations[0].passing_message
    end
  end
end
