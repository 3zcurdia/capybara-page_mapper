# frozen_string_literal: true

module Capybara
  # Pagemap module extend functionality to clases to map capybara nodes
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

    # Configuration class encapsulates gobal configurations
    class Configuration
      attr_accessor :enabled
      def initialize
        @enabled = %i[input button select]
      end
    end
  end
end
