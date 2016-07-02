module Capybara
  module PageMapper
    class Base
      include Capybara::DSL
      @@node_definitions = {}

      def initialize
        @page_nodes = {}
        @page_values = {}
      end

      def valid?
        @page_nodes.map { |n| !!n }.uniq.all?
      end

      def method_missing(method_sym, *arguments, &block)
        if /(?<element_input>.*)_input$/ =~ method_sym && @@node_definitions[element_input.to_sym]
          define_input(element_input)
          send(method_sym)
        elsif /(?<element_button>.*)_button$/ =~ method_sym && @@node_definitions[element_button.to_sym]
          define_button(element_button)
          send(method_sym)
        elsif /(?<element_setter>.*)=$/ =~ method_sym && @@node_definitions[element_setter.to_sym]
          define_input_setter(element_setter)
          send(method_sym, arguments.first)
        elsif @@node_definitions[method_sym.to_sym]
          define_input_getter(method_sym)
          send(method_sym)
        else
          super
        end
      end

      def respond_to?(method_sym, include_private = false)
        /(.*)_input$/ =~ method_sym || /(.*)_button$/ =~ method_sym || /(.*)=$/ =~ method_sym
        return true if @@node_definitions[($1 || method_sym).to_sym]
        super
      end

      protected

      def self.define_input(name, xpath)
        @@node_definitions[name.to_sym] = xpath
      end

      def self.define_button(name, xpath)
        define_input(name, xpath)
      end

      private

      def define_input(key_name)
        instance_eval <<-RUBY
          def #{key_name}_input
            @page_nodes[:#{key_name}] ||= page.find(:xpath, @@node_definitions[:#{key_name}])
          end
        RUBY
      end

      def define_input_setter(key_name)
        instance_eval <<-RUBY
          def #{key_name}=(value)
            self.#{key_name}_input.set(value) if self.#{key_name}_input.respond_to?(:set)
            @page_values[:#{key_name}]=value
          end
        RUBY
      end

      def define_input_getter(key_name)
        instance_eval <<-RUBY
          def #{key_name}
            @page_values[:#{key_name}]
          end
        RUBY
      end

      def define_button(key_name)
        instance_eval <<-RUBY
          def #{key_name}_button
            @#{key_name}_button ||= page.find(:xpath, @@node_definitions[:#{key_name}])
          end
        RUBY
      end
    end
  end
end
