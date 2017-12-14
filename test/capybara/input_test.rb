# frozen_string_literal: true

require 'test_helper'

class Dummy
  include Capybara::Pagemap
  define_input :email, '//*[@id="user_email"]'
  define_input :password, '//*[@id="user_password"]'

  def page
    @page ||= PageMock.new
  end
end

class Capybara::Pagemap::InputTest < Minitest::Test
  def subject
    @subject ||= Dummy.new
  end

  def test_respond_to
    assert subject.respond_to?(:email_input)
    assert subject.respond_to?(:password_input)
    assert subject.respond_to?(:email=)
    assert subject.respond_to?(:password=)
    assert subject.respond_to?(:email)
    assert subject.respond_to?(:password)
  end

  def test_input
    refute_nil subject.email_input
    refute_nil subject.password_input
  end

  def test_setter_and_getter
    refute subject.email_input.value
    subject.email = 'user@example.com'
    assert_equal 'user@example.com', subject.email_input.value
    assert_equal 'user@example.com', subject.email
  end

  def test_valid
    assert subject.valid?
  end
end
