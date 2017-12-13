# frozen_string_literal: true

module Capybara
  module Pagemap
    # Input build methods for input selector
    module Input
      # :nodoc:
      module ClassMethods
        def define_input(name, xpath, type = :input)
          node_definitions[name] = { type: type, value: xpath }
        end
      end

      def input_validator_for(node)
        !send("#{node}_input").nil?
      end

      def input_build_and_send(method_name, *_, &_block)
        return unless /(?<key>.*)_input$/ =~ method_name && self.class.node_definitions[key.to_sym]
        build_input(key.to_sym)
        send(method_name)
      end

      def input_respond_to_missing?(method_name, _include_private = false)
        /(.*)_input$/ =~ method_name || self.class.node_definitions[Regexp.last_match(1).to_sym]
      end

      private

      def build_input(key_name)
        instance_eval <<-RUBY
          def #{key_name}_input
            @#{key_name}_input ||= page.find(:xpath, self.class.node_definitions[:#{key_name}][:value])
          end
        RUBY
      end
    end
  end
end
