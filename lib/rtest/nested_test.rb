module RTest
  class NestedTest

    attr_reader :tests

    def initialize(message, optional_message = '', &block)
      @message = message.to_s << optional_message
      @tests = []
      instance_eval(&block) if block_given?
    end

    def have_to(&block)
      @tests << Test.new(&block)
    end

    def run
      puts @message
      @tests.map { |test| test.run }
    end
  end
end
