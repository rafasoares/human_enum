# frozen_string_literal: true

require 'bundler/setup'
require 'active_record'
require 'human_enum'

RSpec.configure do |config|
  support_path = File.join(config.default_path, 'support')

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Use an in-memory DB since we don't need persistence
  config_file_path = File.join(support_path, 'db', 'database.yml')
  db_config = YAML.safe_load(File.open(config_file_path))

  ActiveRecord::Base.establish_connection(db_config['sqlite3'])
  load File.join(support_path, 'db', 'schema.rb')

  # Set up I18n
  I18n.load_path += Dir[File.join(support_path, 'locales', '*.{rb,yml}')]
  I18n.default_locale = :en
end
