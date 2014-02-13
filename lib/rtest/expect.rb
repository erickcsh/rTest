module RTest
  class Expect

    attr_reader :failure_message, :passing_message

    def initialize(object)
      @object = object
    end

    def to(matcher)
      if(matcher.match?(@object)) 
        @pass = true
        @passing_message = matcher.success_message_for_to
      else @failure_message = matcher.failure_message_for_to
      end
    end

    def not_to(matcher)
      if(matcher.match?(@object)) then @failure_message = matcher.failure_message_for_not_to
      else
        @passing_message = matcher.success_message_for_not_to
        @pass = true
      end
    end

    def pass?
      @pass
    end
  end
end
