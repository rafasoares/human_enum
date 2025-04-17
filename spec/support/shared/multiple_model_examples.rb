# frozen_string_literal: true

RSpec.shared_examples 'multiple models using the same enum name' do |enum_name, **values|
  let(:plural_enum_name) { enum_name.to_s.pluralize }

  let(:first_model_values) { values[:first] }
  let(:second_model_values) { values[:second] }

  describe Multiple::FirstModel do
    subject { described_class.public_send(:"human_#{plural_enum_name}") }

    it { is_expected.to eq first_model_values }
    it { is_expected.not_to eq second_model_values }
  end

  describe Multiple::SecondModel do
    subject { described_class.public_send(:"human_#{plural_enum_name}") }

    it { is_expected.to eq second_model_values }
    it { is_expected.not_to eq first_model_values }
  end
end
