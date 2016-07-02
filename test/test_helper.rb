$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'capybara/page_mapper'
require 'capybara/poltergeist'

require 'minitest/autorun'

Capybara.configure do |config|
  config.run_server = false
  config.current_driver = :poltergeist
  config.app = "fake app"
  config.app_host = "https://google.com/"
end
