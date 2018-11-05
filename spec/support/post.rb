# frozen_string_literal: true

class Post < Statics::Model
  include Statics::Translatable

  filename "posts"

  attribute :title, Types::Strict::String
  attribute? :author, Types::Strict::String.default("Unknown")

  translatable_attribute :body
end
