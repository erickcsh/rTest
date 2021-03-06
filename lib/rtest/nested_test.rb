module RTest
  class NestedTest

    attr_reader :tests

    def initialize(message, optional_message = '', &block)
      @message = message.to_s << optional_message
      @tests = []
      instance_eval(&block) if block_given?
    end

    def has_to(message = nil, &block)
      @tests << Test.new(message, &block)
    end

    def run
      Console.instance.display_leveled_message(0, @message)
      @tests.map { |test| test.run }
    end
  end
end
