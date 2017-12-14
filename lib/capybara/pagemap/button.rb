# frozen_string_literal: true

module Capybara
  module Pagemap
    # Button build methods for clickable DOM elements
    module Button
      # :nodoc
      module ClassMethods
        def define_button(name, xpath)
          node_definitions[name] = { type: :button, value: xpath }
        end
      end

      def button_validator_for(node)
        !send("#{node}_button").nil?
      end

      def button_method_missing(method_name, *_, &_block)
        return unless /(?<key>.*)_button$/ =~ method_name && self.class.node_definitions[key.to_sym] && self.class.node_definitions[key.to_sym][:type] == :button
        build_button(key.to_sym)
        send(method_name)
      end

      def button_respond_to_missing?(method_name, _include_private = false)
        /(?<key>.*)_button$/ =~ method_name && self.class.node_definitions[key.to_sym]
      end

      private

      def build_button(key_name)
        instance_eval <<-RUBY
          def #{key_name}_button
            @#{key_name}_button ||= page.find(:xpath, self.class.node_definitions[:#{key_name}][:value])
          end
        RUBY
      end
    end
  end
end
