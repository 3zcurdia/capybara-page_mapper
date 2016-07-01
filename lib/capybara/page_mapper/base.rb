module Capybara
  module PageMapper
    class Base < Struct
      include Capybara::DSL

      def initialize(*args)
        super
      end

    end
  end
end
