# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'capybara/pagemap'
require 'capybara/poltergeist'

require 'minitest/autorun'
require 'support/pagemock'
require 'support/test_app'

Capybara.configure do |config|
  config.app = TestApp
  config.current_driver = :poltergeist
end
