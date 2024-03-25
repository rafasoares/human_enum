# frozen_string_literal: true

class TestModel < ActiveRecord::Base
  include HumanEnum

  # Old enum syntax
  enum shape: %i[round square]

  # New enum syntax (Rails 7)
  enum :color, %i[red blue]
  enum :size, {
    small: :small,
    large: :large,
  }
end

RSpec.describe HumanEnum do
  it 'has a version number' do
    expect(HumanEnum::VERSION).not_to be nil
  end

  describe 'Model class method' do
    context 'shape' do
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

    context 'color' do
      subject(:values) { TestModel.human_colors }

      let(:expected_values) do
        {
          red: 'Redish',
          blue: 'Bluish'
        }
      end

      it 'returns a Hash with the translated values' do
        expect(values).to eq expected_values
      end
    end

    context 'size' do
      subject(:values) { TestModel.human_sizes }

      let(:expected_values) do
        {
          small: 'Small size',
          large: 'Large size'
        }
      end

      it 'returns a Hash with the translated values' do
        expect(values).to eq expected_values
      end
    end
  end

  describe 'Model instance method' do
    context 'shape' do
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

    context 'color' do
      subject { TestModel.new(params).human_color }

      context 'with a blank value' do
        let(:params) {}

        it { is_expected.to be_nil }
      end

      context 'with enum value = :red' do
        let(:params) { { color: :red } }

        it { is_expected.to eq 'Redish' }
      end
    end

    context 'size' do
      subject { TestModel.new(params).human_size }

      context 'with a blank value' do
        let(:params) {}

        it { is_expected.to be_nil }
      end

      context 'with enum value = :large' do
        let(:params) { { size: :large } }

        it { is_expected.to eq 'Large size' }
      end
    end
  end
end
