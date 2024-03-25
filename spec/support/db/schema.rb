# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table 'test_models' do |t|
    t.string 'shape'
    t.integer 'color'
    t.string 'size'
  end
end
