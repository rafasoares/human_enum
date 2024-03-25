# frozen_string_literal: true

class TestModel < ActiveRecord::Base
  include HumanEnum

  enum my_enum: %i[value other_value]
end

RSpec.describe HumanEnum do
  it 'has a version number' do
    expect(HumanEnum::VERSION).not_to be nil
  end

  describe 'Model class method' do
    subject(:values) { TestModel.human_my_enums }

    let(:expected_values) do
      {
        value: 'Custom value',
        other_value: 'Other custom value'
      }
    end

    it 'returns a Hash with the translated values' do
      expect(values).to eq expected_values
    end
  end

  describe 'Model instance method' do
    subject { TestModel.new(params).human_my_enum }

    context 'with a blank value' do
      let(:params) {}

      it { is_expected.to be_nil }
    end

    context 'with enum value = :other_value' do
      let(:params) { { my_enum: :other_value } }

      it { is_expected.to eq 'Other custom value' }
    end
  end
end
