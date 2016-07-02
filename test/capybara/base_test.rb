require 'test_helper'

class DummyMock < Capybara::PageMapper::Base
  define_input :email, '//*[@id="user_email"]'
  define_input :password, '//*[@id="user_password"]'
  define_button :log_in, '//*[@id="log_in"]'
end

class Capybara::PageMapper::BaseTest < Minitest::Test
  def base
    @base ||= DummyMock.new
    @base.email = 'test@example.org'
    @base.password = 'secret'
    @base
  end

  def setup
    base.visit '/'
  end

  def test_attribues
    assert_equal 'secret', base.password
    assert_equal 'test@example.org', base.email
  end

  def test_inputs
    refute_nil base.email_input
    refute_nil base.password_input
  end

  def test_button
    refute_nil base.log_in_button
  end

  def test_valid
    assert base.valid?
  end
end
