# frozen_string_literal: true

require 'test_helper'

class DummySelect
  include Capybara::Pagemap
  define_select :age, '//*[@id="age"]'

  def page
    PageMock.new
  end
end

class Capybara::Pagemap::SelectTest < Minitest::Test
  def subject
    @subject ||= DummySelect.new
  end

  def test_respond_to
    assert subject.respond_to?(:age_input)
    assert subject.respond_to?(:age_select)
    assert subject.respond_to?(:age_select_by)
  end

  def test_input
    refute_nil subject.age_input
    refute_nil subject.age_select('18')
    refute_nil subject.age_select_by('2')
  end

  def test_valid
    assert subject.valid?
  end
end
