# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table 'test_models' do |t|
    t.string 'my_enum'
  end
end
