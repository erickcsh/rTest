module RTest
  module MainTest

    @@tests = []

    def describe(message, optional_message = '', &block)
      @@tests << NestedTest.new(message, optional_message, &block)
    end

    def self.run_tests
      @@tests.map { |test| test.run }
    end
  end
end
