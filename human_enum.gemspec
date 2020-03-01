# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'human_enum/version'

Gem::Specification.new do |spec|
  spec.name          = 'human_enum'
  spec.version       = HumanEnum::VERSION
  spec.authors       = ['Rafael Soares']
  spec.email         = ['rafasoaresms@gmail.com']

  spec.summary       = 'Adds simple and easy I18n support for Rails enums'
  spec.description   = 'This gem allows you to specify enum value translations
    like any other ActiveRecord attribute and adds helper methods to get
    humanized translations of enum values'
  spec.homepage      = 'https://github.com/rafasoares/human_enum'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rafasoares/human_enum'
  spec.metadata['changelog_uri'] = 'https://github.com/rafasoares/human_enum/blob/master/CHANGELOG.md'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.18.5'

  spec.add_development_dependency 'rubocop', '~> 0.72.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.36'

  spec.add_development_dependency 'reek', '~> 5.6.0'

  spec.add_development_dependency 'guard', '~> 2.15'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.3'

  spec.add_development_dependency 'sqlite3', '~> 1.4'

  spec.add_dependency 'activerecord', '> 5.0.0'
end
