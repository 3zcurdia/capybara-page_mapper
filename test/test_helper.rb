# frozen_string_literal: true
require 'simplecov'
SimpleCov.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'capybara/pagemap'
require 'minitest/autorun'
require 'support/pagemock'
