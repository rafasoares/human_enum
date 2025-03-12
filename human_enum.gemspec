# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'human_enum/version'

Gem::Specification.new do |spec|
  spec.name          = 'human_enum'
  spec.version       = HumanEnum::VERSION
  spec.authors       = ['Rafael Soares']
  spec.email         = ['893971+rafasoares@users.noreply.github.com']

  # Should always be the lowest maintained version of Ruby
  spec.required_ruby_version = '>= 3.1'

  spec.summary       = 'Adds simple and easy I18n support for Rails enums'
  spec.description   = 'This gem allows you to specify enum value translations
    like any other ActiveRecord attribute and adds helper methods to get
    humanized translations of enum values'
  spec.homepage      = 'https://github.com/rafasoares/human_enum'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rafasoares/human_enum'
  spec.metadata['changelog_uri'] = 'https://github.com/rafasoares/human_enum/blob/main/CHANGELOG.md'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 6.1', '< 9'
end
