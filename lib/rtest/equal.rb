module RTest
  class Equal

    def initialize(object)
      @match_object = object
    end

    def match?(compare_object)
      @compare_object = compare_object
      @match_object == @compare_object
    end
  end
end
