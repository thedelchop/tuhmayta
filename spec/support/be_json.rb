module CustomMatcher
  class BeJSON
    def intialize(expected)
      @expected = expected
    end

    def matches?(actual)
      @actual = actual
      ActiveSupport::JSON.decode(@actual) == ActiveSupport::JSON.decode(@expected)
    end

    def failure_message_for_should
      "expected #{@actual.inspect} to equal #{@expected.inspect} but the JSON was different"
    end

    def failure_message_for_should_not
      "expected #{@actual.inspect} to differ from #{@expected.inspect} but they are the same"
    end
  end

  def be_json(expected)
    BeJSON.new(expected)
  end
end
