$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'capybara/page_mapper'
require 'capybara/poltergeist'

require 'minitest/autorun'
require 'support/test_app'

Capybara.configure do |config|
  config.app = TestApp
  config.current_driver = :poltergeist
  # config.run_server = false
  # config.app_host = "https://google.com/"
end
