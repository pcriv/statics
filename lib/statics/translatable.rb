# frozen_string_literal: true

module Statics
  module Translatable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def translatable_attributes(*names, **options)
        names.each { |name| translatable_attribute(name, options) }
      end

      def translatable_attribute(name, options = {})
        attribute(name, Types::Translations.meta(omittable: options.fetch(:optional, false)))
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
