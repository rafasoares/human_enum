# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require 'bundler/setup'
require 'human_enum'

Dir[File.join(__dir__, 'support', '*.rb')].each { |f| require f }
