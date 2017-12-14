# frozen_string_literal: true

# :nodoc:
class PageMock
  # :nodoc:
  class PageNodeMock
    class Selector
      def select_option
        true
      end
    end
    attr_reader :value
    def set(value)
      @value = value
    end

    def select(_)
      true
    end

    def find(*_)
      Selector.new
    end
  end

  def find(*_)
    PageNodeMock.new
  end
end
