# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

plugin 'bundler-multilock', '~> 1.4'
return unless Plugin.installed?('bundler-multilock')

Plugin.send(:load_plugin, 'bundler-multilock')

lockfile do
  gem 'activerecord', '~> 8.0'
end

# rubocop:disable Bundler/DuplicatedGem
lockfile 'rails-7.1' do
  gem 'activerecord', '~> 7.1.0'
end

lockfile 'rails-7.2' do
  gem 'activerecord', '~> 7.2.0'
end

lockfile 'rails-8.0' do
  gem 'activerecord', '~> 8.0.0'
end
# rubocop:enable Bundler/DuplicatedGem

gem 'rake', '~> 13.0'
gem 'rspec', '~> 3.12'
gem 'sqlite3', '~> 2.0'

# Should match the version in .codeclimate.yml
gem 'rubocop', '~> 1.56.3'
gem 'rubocop-performance'
gem 'rubocop-rails'
gem 'rubocop-rake'
gem 'rubocop-rspec'

gem 'ruby-lsp-rails'
gem 'ruby-lsp-rspec', require: false

gem 'guard', '~> 2.18'
gem 'guard-rspec', '~> 4.7'
gem 'guard-rubocop', '~> 1.5'

gem 'simplecov', '~> 0.22.0'
