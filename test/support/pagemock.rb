# frozen_string_literal: true

# :nodoc:
class PageMock
  # :nodoc:
  class PageNodeMock
    attr_reader :value
    def set(value)
      @value = value
    end
  end

  def find(*_)
    PageNodeMock.new
  end
end
