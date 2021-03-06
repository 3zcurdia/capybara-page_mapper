# frozen_string_literal: true

module Capybara
  module Pagemap
    # Select build methods for selectable DOM elements
    module Select
      # :nodoc
      module ClassMethods
        def define_select(name, xpath)
          node_definitions[name] = { type: :select, value: xpath }
        end
      end

      def select_validator_for(node)
        !send("#{node}_input").nil?
      end

      def select_method_missing(method_name, args, block)
        select_input_build_and_send(method_name, args, block) ||
          select_opt_build_and_send(method_name, args, block) ||
          select_value_build_and_send(method_name, args, block) ||
          select_getter_build_and_send(method_name, args, block)
      end

      def select_input_build_and_send(method_name, _args, _block)
        return unless /(?<key>.*)_input$/ =~ method_name && self.class.node_definitions[key.to_sym]
        build_select_input(key)
        send(method_name)
      end

      def select_opt_build_and_send(method_name, args, _block)
        return unless /(?<key>.*)_select$/ =~ method_name && self.class.node_definitions[key.to_sym] && self.class.node_definitions[key.to_sym][:type] == :select
        build_select_opt(key)
        send(method_name, args.first)
      end

      def select_value_build_and_send(method_name, args, _block)
        return unless /(?<key>.*)_select_by$/ =~ method_name && self.class.node_definitions[key.to_sym] && self.class.node_definitions[key.to_sym][:type] == :select
        build_select_by(key)
        send(method_name, args.first)
      end

      def select_getter_build_and_send(method_name, _args, _block)
        return unless self.class.node_definitions[method_name.to_sym]
        build_select_getter(method_name)
        send(method_name)
      end

      def select_respond_to_missing?(method_name, _include_private = false)
        /(.*)_input$/ =~ method_name ||
          /(.*)_select$/ =~ method_name ||
          /(.*)_select_by$/ =~ method_name ||
          self.class.node_definitions[(Regexp.last_match(1) || method_name).to_sym]
      end

      private

      def build_select_input(key_name)
        instance_eval <<-RUBY
          def #{key_name}_input
            @#{key_name}_input ||= page.find(:xpath, self.class.node_definitions[:#{key_name}][:value])
          end
        RUBY
      end

      def build_select_opt(key_name)
        instance_eval <<-RUBY
          def #{key_name}_select(option)
            @#{key_name}_input.select(option) if self.#{key_name}_input.respond_to?(:select)
          end
        RUBY
      end

      def build_select_by(key_name)
        instance_eval <<-RUBY
          def #{key_name}_select_by(value)
            self.#{key_name}_input.find("option[value='"+value+"']").select_option if self.#{key_name}_input.respond_to?(:find)
          end
        RUBY
      end

      def build_select_getter(key_name)
        instance_eval <<-RUBY
          def #{key_name}
            self.#{key_name}_input.value
          end
        RUBY
      end
    end
  end
end
