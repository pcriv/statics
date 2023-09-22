# frozen_string_literal: true

module Statics
  class Model < Dry::Struct
    module Types
      include Statics::Types
    end

    transform_keys(&:to_sym)

    defines :filename

    attribute :key, Types::Strict::Symbol.constructor(&:to_sym)

    class << self
      # @param key [Symbol]
      # @raise [Statics::KeyNotFoundError] if key is not found.
      # @return [Statics::Model]
      def [](key)
        new(file_contents.fetch(key.to_s) { raise KeyNotFoundError }.merge(key: key.to_sym))
      end

      # @return [Statics::Collection]
      def all
        @all ||= Collection.new(records)
      end

      def method_missing(method, *, &block)
        if Collection.instance_methods.include?(method)
          all.public_send(method, *, &block)
        else
          super
        end
      end

      def respond_to_missing?(method, include_private = false)
        Collection.instance_methods(false).include?(method) || super
      end

      private

      # @return [Hash]
      def file_contents
        @file_contents ||= YAML.load_file(path)
      end

      # @return [Array<Statics::Model>]
      def records
        file_contents.map do |key, attributes|
          new(attributes.merge(key: key.to_sym))
        end
      end

      # @return [String]
      def path
        File.join(Statics.data_path, "#{filename}.yml")
      end
    end
  end
end
