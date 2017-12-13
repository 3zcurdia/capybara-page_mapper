# frozen_string_literal: true

require 'test_helper'

class PageMock
  def find(*_)
    true
  end
end

class Dummy
  include Capybara::Pagemap
  define_input :email, '//*[@id="user_email"]'
  define_input :password, '//*[@id="user_password"]'

  def nodes
    @nodes ||= {}
  end

  def page
    PageMock.new
  end
end

class Capybara::Pagemap::InputTest < Minitest::Test
  def subject
    @subject ||= Dummy.new
  end

  def test_respond_to
    assert subject.respond_to?(:email_input)
    assert subject.respond_to?(:password_input)
  end

  def test_input
    refute_nil subject.email_input
    refute_nil subject.password_input
  end

  def test_valid
    assert subject.valid?
  end
end
