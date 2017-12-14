# frozen_string_literal: true

module Capybara
  module Pagemap
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    class Configuration
      attr_accessor :enabled
      def initialize
        @enabled = %i[input button]
      end
    end
  end
end
