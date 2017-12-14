# frozen_string_literal: true

require 'test_helper'

module Capybara
  module Pagemap
    class ConfigurationTest < Minitest::Test
      def test_config_enabled
        assert_equal %i[input button select], Capybara::Pagemap.configuration.enabled
        Capybara::Pagemap.configure do |config|
          config.enabled = %i[input collection button]
        end
        assert_equal %i[input collection button], Capybara::Pagemap.configuration.enabled
      end
    end
  end
end
