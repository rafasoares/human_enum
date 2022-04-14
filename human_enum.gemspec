# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "human_enum/version"

Gem::Specification.new do |spec|
  spec.name          = "human_enum"
  spec.version       = HumanEnum::VERSION
  spec.authors       = ["Rafael Soares"]
  spec.email         = ["893971+rafasoares@users.noreply.github.com"]

  spec.summary       = "Adds simple and easy I18n support for Rails enums"
  spec.description   = <<~DESC
    This gem allows you to specify enum value translations
    like any other ActiveRecord attribute and adds helper methods to get
    humanized translations of enum values
  DESC

  spec.homepage      = "https://github.com/rafasoares/human_enum"
  spec.license       = "MIT"
  spec.required_ruby_version = "~> 2.7"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rafasoares/human_enum"
  spec.metadata["changelog_uri"] = "https://github.com/rafasoares/human_enum/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|github|vscode)|appveyor)})
    end
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 7.0"
  spec.metadata["rubygems_mfa_required"] = "true"
end
