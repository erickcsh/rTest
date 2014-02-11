module RTest
  class Equal

    def initialize(object)
      @match_object = object
    end

    def match?(compare_object)
      @compare_object = compare_object
      @match_object == @compare_object
    end

    def failure_message_for_to
      "does not match, expecting #{@match_object}, got #{@compare_object}"
    end

    def failure_message_for_not_to
      "match, expecting somthing different to #{@match_object}, got #{@compare_object}"
    end
  end
end
