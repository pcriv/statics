# frozen_string_literal: true

module Statics
  module Types
    include Dry::Types.module

    Translations = Types::Map(Types::Strict::Symbol.constructor(&:to_sym), Types::Strict::String)
  end
end
