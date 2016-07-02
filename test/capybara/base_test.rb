require 'test_helper'

class DummyMock < Capybara::PageMapper::Base
  define_field :email, '//*[@id="user_email"]'
  define_field :password, '//*[@id="user_password"]'
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

  def test_fields
    refute_nil base.email_field
    refute_nil base.password_field
  end

  def test_button
    refute_nil base.log_in_button
  end
end
