# frozen_string_literal: true

require 'simplecov'
require 'simplecov_json_formatter'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter
    .new([
           SimpleCov::Formatter::JSONFormatter,
           SimpleCov::Formatter::HTMLFormatter
         ])

  add_filter '/spec/'
end

require 'bundler/setup'
require 'human_enum'

Dir[File.join(__dir__, 'support', '**', '*.rb')].each { |f| require f }
