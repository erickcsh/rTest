module RTest
  class Expect

    attr_reader :failure_message

    def initialize(object)
      @object = object
    end

    def to(matcher)
      if(matcher.match?) then @pass = true
      else @failure_message = matcher.failure_message_for_to
      end
    end

    def not_to(matcher)
      if(matcher.match?) then @failure_message = matcher.failure_message_for_not_to
      else @pass = true
      end
    end

    def pass?
      @pass
    end
  end
end
