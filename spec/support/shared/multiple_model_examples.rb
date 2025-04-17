# frozen_string_literal: true

RSpec.shared_examples 'multiple models' do |enum_name, **values|
  let(:plural_enum_name) { enum_name.to_s.pluralize }

  shared_examples 'multiple models using the same enum name' do |one, other|
    describe 'Model class methods' do
      subject { described_class.public_send(:"human_#{plural_enum_name}") }

      it { is_expected.to eq one }
      it { is_expected.not_to eq other }
    end

    describe 'Model instance methods' do
      one.each do |value, translation|
        context "when #{enum_name} is #{value}" do
          subject { described_class.new(enum_name => value).public_send(:"human_#{enum_name}") }

          it { is_expected.to eq translation }
        end
      end

      other.each do |value, _|
        it "doesn't allow #{value} as a value" do
          expect { described_class.new(enum_name => value) }
            .to raise_error(ArgumentError, a_string_including(value.to_s, 'is not a valid', enum_name.to_s))
        end
      end
    end
  end

  describe Multiple::FirstModel do
    it_behaves_like 'multiple models using the same enum name', values[:first], values[:second]
  end

  describe Multiple::SecondModel do
    it_behaves_like 'multiple models using the same enum name', values[:second], values[:first]
  end
end
