module RTest
  class Test

    attr_reader :expectations

    def initialize(message = nil, &block)
      @message = message
      @expectations = []
      instance_eval(&block) if block_given?
    end

    def expect(object)
      @expectations << Expect.new(object)
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
    def run_test_result
      begin
        run_expectations
        puts "\t#{success_message}"
      rescue TestFailureError => error
        error_message(error)
      end
    end

    def error_message(error)
      puts "\t#{@message}"
      puts "\t\t#{error.message}"
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

    def first_expectation_message
      @expectations[0].passing_message
    end
  end
end
