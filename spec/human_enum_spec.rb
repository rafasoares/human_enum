# frozen_string_literal: true

class TestModel < ActiveRecord::Base
  include HumanEnum

  enum shape: %i[round square]
end

RSpec.describe HumanEnum do
  it 'has a version number' do
    expect(HumanEnum::VERSION).not_to be nil
  end

  describe 'Model class method' do
    subject(:values) { TestModel.human_shapes }

    let(:expected_values) do
      {
        round: 'Round',
        square: 'Square'
      }
    end

    it 'returns a Hash with the translated values' do
      expect(values).to eq expected_values
    end
  end

  describe 'Model instance method' do
    subject { TestModel.new(params).human_shape }

    context 'with a blank value' do
      let(:params) {}

      it { is_expected.to be_nil }
    end

    context 'with enum value = :square' do
      let(:params) { { shape: :square } }

      it { is_expected.to eq 'Square' }
    end
  end
end
