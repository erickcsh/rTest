module RTest
  class Equal

    FAILURE_MESSAGE_FOR_TO = "does not match, expecting {match}, got {compare}"
    FAILURE_MESSAGE_FOR_NOT_TO = "match, expecting somthing different to {match}, got {compare}"
    SUCCESS_MESSAGE_FOR_TO = "objects match"
    SUCCESS_MESSAGE_FOR_NOT_TO = "objects does not match"

    def initialize(object)
      @match_object = object
    end

    def match?(compare_object)
      @compare_object = compare_object
      @match_object == @compare_object
    end

    def failure_message_for_to
      substitute_comparisons(FAILURE_MESSAGE_FOR_TO)
    end

    def failure_message_for_not_to
      substitute_comparisons(FAILURE_MESSAGE_FOR_NOT_TO)
    end

    def success_message_for_to
      SUCCESS_MESSAGE_FOR_TO
    end

    def success_message_for_not_to
      SUCCESS_MESSAGE_FOR_NOT_TO
    end

    private
    def substitute_comparisons(message)
      message = message.sub(/{match}/, @match_object.to_s)
      message.sub(/{compare}/, @compare_object.to_s)
    end
  end
end
