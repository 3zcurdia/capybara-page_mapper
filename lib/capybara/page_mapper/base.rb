module Capybara
  module PageMapper
    class Base
      include Capybara::DSL
      @@node_definitions = {}

      def initialize
        @page_nodes = {}
        @page_values = {}
      end

      protected

      def self.define_field(name, xpath)
        @@node_definitions[name.to_sym] = xpath
      end

      def method_missing(method_sym, *arguments, &block)
        if /(?<element_field>.*)_field$/ =~ method_sym && @@node_definitions[element_field.to_sym]
          define_field(element_field)
          send(method_sym)
        elsif /(?<element_button>.*)_button$/ =~ method_sym && @@node_definitions[element_button.to_sym]
          define_button(element_button)
          send(method_sym)
        elsif /(?<element_setter>.*)=$/ =~ method_sym && @@node_definitions[element_setter.to_sym]
          define_field_setter(element_setter)
          send(method_sym, arguments.first)
        elsif @@node_definitions[method_sym.to_sym]
          define_field_getter(method_sym)
          send(method_sym)
        else
          super
        end
      end

      private

      def define_field(key_name)
        instance_eval <<-RUBY
          def #{key_name}_field
            @page_nodes[:#{key_name}] ||= page.find(:xpath, @@node_definitions[:#{key_name}])
          end
        RUBY
      end

      def define_field_setter(key_name)
        instance_eval <<-RUBY
          def #{key_name}=(value)
            @page_values[:#{key_name}]=value
          end
        RUBY
      end

      def define_field_getter(key_name)
        instance_eval <<-RUBY
          def #{key_name}
            @page_values[:#{key_name}]
          end
        RUBY
      end

      def define_button(key_name, xpath)
        instance_eval <<-RUBY
          def #{key_name}_button
            @#{key_name}_button ||= page.find(:xpath, xpath)
          end
        RUBY
      end
    end
  end
end
