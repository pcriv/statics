# frozen_string_literal: true

require "dry/configurable"
require "dry/struct"
require "dry/core"
require "i18n"
require "yaml"
require "forwardable"

require "statics/errors"
require "statics/types"
require "statics/collection"
require "statics/model"
require "statics/translatable"
require "statics/version"

module Statics
  extend Dry::Configurable

  setting :data_path, reader: true
end
