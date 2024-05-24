# frozen_string_literal: true

RSpec.shared_examples 'translations' do |enum_name, values|
  let(:plural_enum_name) { enum_name.to_s.pluralize }
  describe 'Model class methods' do
    subject(:translated_values) { TestModel.public_send(:"human_#{plural_enum_name}") }

    it { is_expected.to eq values }
  end

  describe 'Model instance method' do
    values.each do |value, translation|
      context "when #{enum_name} is #{value}" do
        subject { TestModel.new(enum_name => value).public_send(:"human_#{enum_name}") }

        it { is_expected.to eq translation }
      end
    end
  end
end
