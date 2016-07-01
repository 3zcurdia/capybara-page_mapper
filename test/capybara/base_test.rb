require 'test_helper'

class DummyMock < Capybara::PageMapper::Base.new(:email, :password)
end

class Capybara::PageMapper::BaseTest < Minitest::Test
  def base
    @base ||= DummyMock.new('test@example.org', 'secret')
  end

  def test_attribues
    assert_equal 'secret', base.password
    assert_equal 'test@example.org', base.email
  end
end
