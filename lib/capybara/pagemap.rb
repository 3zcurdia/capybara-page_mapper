# frozen_string_literal: true

require 'capybara/pagemap/version'
require 'capybara/pagemap/configuration'
require 'capybara/pagemap/input'
require 'capybara/pagemap/button'
require 'capybara/pagemap/select'

module Capybara
  module Pagemap
    # Modules Available
    include Input
    include Button
    include Select
    MODULES_ENABLED = configuration.enabled.freeze

    def self.included(base)
      base.extend(ClassMethods)
      MODULES_ENABLED.each do |mod|
        base.extend(Object.const_get("Capybara::Pagemap::#{mod.capitalize}::ClassMethods"))
      end
    end

    module ClassMethods
      def node_definitions
        @node_definitions ||= {}
      end
    end

    def valid?
      self.class.node_definitions.any? && self.class.node_definitions.map do |node, definition|
        MODULES_ENABLED.map do |type|
          next if definition[:type] != type
          send("#{type}_validator_for", node)
        end.compact.all?
      end.all?
    end

    def method_missing(method_name, *args, &block)
      self.class.node_definitions.any? && self.class.node_definitions.each do |_, definition|
        MODULES_ENABLED.each do |type|
          next if definition[:type] != type
          return send("#{type}_method_missing", method_name, args, block) if respond_to?(method_name)
        end
      end
      super
    end

    def respond_to_missing?(method_name, include_private = false)
      self.class.node_definitions.map do |_, definition|
        MODULES_ENABLED.map do |type|
          next if definition[:type] != type
          send("#{type}_respond_to_missing?", method_name, include_private)
        end.compact.all?
      end.all?
    end
  end
end
