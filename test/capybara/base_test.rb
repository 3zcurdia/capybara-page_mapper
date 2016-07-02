require 'test_helper'

class DummyMock < Capybara::PageMapper::Base
  define_field :email, '//*[@id="user_email"]'
  define_field :password, '//*[@id="user_password"]'
  # set_button :log_in, '//*[@id="content"]/div[2]/div/form/a'
end

class Capybara::PageMapper::BaseTest < Minitest::Test
  def base
    @base ||= DummyMock.new
    @base.email = 'test@example.org'
    @base.password = 'secret'
    @base
  end

  def test_attribues
    assert_equal 'secret', base.password
    assert_equal 'test@example.org', base.email
  end
end
