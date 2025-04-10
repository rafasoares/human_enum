# frozen_string_literal: true

RSpec.shared_examples 'multiple models' do
  let(:enum_name) { :status }
  let(:plural_enum_name) { enum_name.to_s.pluralize }
  let(:first_model_values) { { active: 'First Active', inactive: 'First Inactive' } }
  let(:second_model_values) { { pending: 'Second Pending', completed: 'Second Completed' } }

  before do
    # Define test models
    stub_const('FirstModel', Class.new(ActiveRecord::Base) do
      include HumanEnum
      enum :status, { active: 0, inactive: 1 }
    end)
    stub_const('SecondModel', Class.new(ActiveRecord::Base) do
      include HumanEnum
      enum :status, { pending: 0, completed: 1 }
    end)

    # Setup FirstModel translations
    first_model_values.each do |key, value|
      allow(I18n).to receive(:t)
        .with(:"activerecord.attributes.first_model.#{plural_enum_name}.#{key}", any_args)
        .and_return(value)
    end

    # Setup SecondModel translations
    second_model_values.each do |key, value|
      allow(I18n).to receive(:t)
        .with(:"activerecord.attributes.second_model.#{plural_enum_name}.#{key}", any_args)
        .and_return(value)
    end
  end

  it "FirstModel has its own human_\#{plural_enum_name} method with correct translations" do
    expect(FirstModel.public_send(:"human_#{plural_enum_name}")).to eq(first_model_values)
  end

  it "SecondModel has its own human_\#{plural_enum_name} method with correct translations" do
    expect(SecondModel.public_send(:"human_#{plural_enum_name}")).to eq(second_model_values)
  end

  it "models have different human_\#{plural_enum_name} results" do
    expect(FirstModel.public_send(:"human_#{plural_enum_name}"))
      .not_to eq(SecondModel.public_send(:"human_#{plural_enum_name}"))
  end
end
