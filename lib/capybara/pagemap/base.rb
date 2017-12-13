# frozen_string_literal: true

module Capybara
  module Pagemap
    class Base
      include Capybara::DSL

      def initialize
        @nodes = {}
      end

      def valid?
        nodes = self.class.node_definitions.keys
        nodes.any? && nodes.map do |node, _|
          !!(send("#{node}_input") || send("#{node}_button"))
        end.uniq.all?
      end

      def method_missing(method_sym, *arguments, &block)
        if /(?<element_input>.*)_input$/ =~ method_sym && self.class.node_definitions[element_input.to_sym]
          define_input(element_input)
          send(method_sym)
        elsif /(?<element_select>.*)_select$/ =~ method_sym && self.class.node_definitions[element_select.to_sym] && self.class.node_definitions[element_select.to_sym][:type] == :select
          define_select(element_select)
          send(method_sym, arguments.first)
        elsif /(?<element_select_value>.*)_select_by_value$/ =~ method_sym && self.class.node_definitions[element_select_value.to_sym] && self.class.node_definitions[element_select_value.to_sym][:type] == :select
          define_select_by_value(element_select_value)
          send(method_sym, arguments.first)
        elsif /(?<element_button>.*)_button$/ =~ method_sym && self.class.node_definitions[element_button.to_sym] && self.class.node_definitions[element_button.to_sym][:type] == :button
          define_button(element_button)
          send(method_sym)
        elsif /(?<element_setter>.*)=$/ =~ method_sym && self.class.node_definitions[element_setter.to_sym]
          define_input_setter(element_setter)
          send(method_sym, arguments.first)
        elsif self.class.node_definitions[method_sym.to_sym]
          define_input_getter(method_sym)
          send(method_sym)
        else
          super
        end
      end

      def respond_to_missing?(method_name, include_private = false)
        /(.*)_input$/ =~ method_name || /(.*)_select$/ =~ method_name || /(.*)_select_by_value$/ =~ method_name || /(.*)_button$/ =~ method_name || /(.*)=$/ =~ method_name
        self.class.node_definitions[(Regexp.last_match(1) || method_name).to_sym] || super
      end

      def self.node_definitions
        @node_definitions ||= {}
      end

      def self.define_input(name, xpath, type = :input)
        node_definitions[name.to_sym] = { type: type, value: xpath }
      end

      def self.define_select(name, xpath)
        define_input(name, xpath, :select)
      end

      def self.define_button(name, xpath)
        define_input(name, xpath, :button)
      end

      private

      def define_input(key_name)
        instance_eval <<-RUBY
          def #{key_name}_input
            @nodes[:#{key_name}] ||= page.find(:xpath, self.class.node_definitions[:#{key_name}][:value])
          end
        RUBY
      end

      def define_select(key_name)
        instance_eval <<-RUBY
          def #{key_name}_select(option)
            self.#{key_name}_input.select(option) if self.#{key_name}_input.respond_to?(:select)
          end
        RUBY
      end

      def define_select_by_value(key_name)
        instance_eval <<-RUBY
          def #{key_name}_select_by_value(value)
            self.#{key_name}_input.find("option[value='"+value+"']").select_option if self.#{key_name}_input.respond_to?(:find)
          end
        RUBY
      end

      def define_input_setter(key_name)
        instance_eval <<-RUBY
          def #{key_name}=(value)
            self.#{key_name}_input.set(value) if self.#{key_name}_input.respond_to?(:set)
          end
        RUBY
      end

      def define_input_getter(key_name)
        instance_eval <<-RUBY
          def #{key_name}
            self.#{key_name}_input.value
          end
        RUBY
      end

      def define_button(key_name)
        instance_eval <<-RUBY
          def #{key_name}_button
            @#{key_name}_button ||= page.find(:xpath, self.class.node_definitions[:#{key_name}][:value])
          end
        RUBY
      end
    end
  end
end
