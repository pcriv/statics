# frozen_string_literal: true

module Statics
  class Collection
    extend Forwardable
    include Enumerable
    include Dry::Equalizer(:records)

    def_delegators :@records, :last, :size

    # @param records [Array<Statics::Model>]
    def initialize(records)
      @records = records
    end

    # @return [Statics::Collection]
    def each(&block)
      self.class.new(records.each(&block))
    end

    # @return [Statics::Collection]
    def select(&block)
      self.class.new(records.select(&block))
    end

    # @return [Statics::Collection]
    def reject(&block)
      self.class.new(records.reject(&block))
    end

    # @param conditions [Hash]
    # @return [Statics::Collection]
    def where(conditions)
      select { |record| filter?(record, conditions) }
    end

    # @param conditions [Hash]
    # @return [Statics::Collection]
    def where_not(conditions)
      reject { |record| filter?(record, conditions) }
    end

    # @param conditions [Hash]
    # @return [Statics::Model]
    def find_by(conditions)
      find { |record| filter?(record, conditions) }
    end

    # @return [Array<Symbol>]
    def keys
      pluck(:key)
    end

    # @param attributes [Array<Symbol>]
    # @return [Array<Object>]
    def pluck(*attributes)
      map { |record| record.attributes.slice(*attributes).values }
        .tap { |result| result.flatten! if attributes.size == 1 }
    end

    private

    attr_reader :records

    # @param record [Static::Model]
    # @param conditions [Hash]
    # @return [true, false]
    def filter?(record, conditions)
      conditions.all? do |attribute, value|
        case value
        when Array
          value.include?(record.send(attribute))
        else
          record.send(attribute) == value
        end
      end
    end
  end
end
