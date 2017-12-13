# frozen_string_literal: true

require 'ostruct'
require 'capybara'
require 'capybara/dsl'
require 'capybara/pagemap/version'
require 'capybara/pagemap/base'
require 'capybara/pagemap/input'
require 'capybara/pagemap/button'

module Capybara
  module Pagemap
    # Available modules
    include Input
    include Button
    MODULES_ENABLED = %i[input button].freeze

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def node_definitions
        @node_definitions ||= {}
      end

      def define_input(name, xpath, type = :input)
        node_definitions[name] = { type: type, value: xpath }
      end
    end

    def valid?
      self.class.node_definitions.any? && self.class.node_definitions.map do |node, _|
        MODULES_ENABLED.map do |type|
          send("#{type}_validator_for", node)
        end.all?
      end.all?
    end

    def method_missing(method_name, *args, &block)
      MODULES_ENABLED.map do |type|
        send("#{type}_build_and_send", method_name, args, block)
      end.compact.all? || super
    end

    def respond_to_missing?(method_name, include_private = false)
      self.class.node_definitions.map do |node, definition|
        MODULES_ENABLED.map do |type|
          next if definition[:type] != type
          send("#{type}_respond_to_missing?", method_name, include_private)
        end.compact.all?
      end.all? || self.class.node_definitions[method_name.to_sym]
    end
  end
end
