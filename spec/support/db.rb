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
      t.integer 'size'
      t.string 'color'
      t.string 'shape'
      t.string 'direction'
    end

    create_table 'first_models' do |t|
      t.integer 'status'
    end

    create_table 'second_models' do |t|
      t.integer 'status'
    end
  end
end
