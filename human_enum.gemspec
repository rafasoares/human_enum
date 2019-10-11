# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'human_enum/version'

Gem::Specification.new do |spec|
  spec.name          = "human_enum"
  spec.version       = HumanEnum::VERSION
  spec.authors       = ["Rafael Soares"]
  spec.email         = ["rafasoaresms@gmail.com"]

  spec.summary       = %q{Adds simple and easy I18n support for Rails enums}
  spec.description   = %q{This gem allows you to specify enum value translations
    like any other ActiveRecord attribute and adds helper methods to get
    humanized translations of enum values}
  spec.homepage      = "https://github.com/rafasoares/human_enum"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency 'rubocop', '~> 0.75'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.36'

  spec.add_dependency "activerecord",  '> 5.0.0'
end
