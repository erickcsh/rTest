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
      success_message = @message || @expectations[0].passing_message
      puts "\t#{success_message}"
    end
  end
end
