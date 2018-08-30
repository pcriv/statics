# frozen_string_literal: true

module Statics
  module Translatable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def translatable_attributes(*names)
        names.each { |name| translatable_attribute(name) }
      end

      def translatable_attribute(name)
        attribute(name, Types::Map(Types::Strict::Symbol.constructor(&:to_sym), Types::Strict::String))
        override_translatable_attribute_getter(name)
      end

      def override_translatable_attribute_getter(name)
        define_method(name) do |locale: I18n.locale|
          attributes.dig(name, locale.to_sym)
        end
      end
    end
  end
end
