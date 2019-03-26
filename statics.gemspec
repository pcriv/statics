# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "statics/version"

Gem::Specification.new do |spec|
  spec.name = "statics"
  spec.email = ["pablocrivella@gmail.com"]
  spec.license = "MIT"
  spec.version = Statics::VERSION
  spec.authors = ["Pablo Crivella"]
  spec.homepage = "https://github.com/pablocrivella/statics"
  spec.summary = "Base class and modules for static models."
  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/pablocrivella/statics/issues",
    "changelog_uri"   => "https://github.com/pablocrivella/statics/blob/master/CHANGELOG.md",
    "source_code_uri" => "https://github.com/pablocrivella/statics"
  }
  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "dry-equalizer", "~> 0.2"
  spec.add_runtime_dependency "dry-struct", "~> 1.0"
  spec.add_runtime_dependency "dry-types", "~> 1.0"
  spec.add_runtime_dependency "i18n", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "pry", "~> 0.12"
  spec.add_development_dependency "pry-byebug", "~> 3.7"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.4"
  spec.add_development_dependency "rubocop", "~> 0.66"
  spec.add_development_dependency "rubocop-rspec", "~> 1.30"
  spec.add_development_dependency "simplecov", "~> 0.16"
end
