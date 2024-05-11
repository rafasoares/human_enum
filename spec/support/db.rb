# frozen_string_literal: true

require 'active_record'

RSpec.configure do |_config|
  ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: ':memory:',
    encoding: 'utf8'
  )

  ActiveRecord::Schema.define do
    create_table 'test_models' do |t|
      t.string 'my_enum'
    end
  end
end
