# frozen_string_literal: true

require 'setup_helper'

RSpec.describe HumanEnum do
  it 'has a version number' do
    expect(HumanEnum::VERSION).not_to be_nil
  end

  if ActiveRecord.gem_version < '7.2'
    context 'with Rails < 7 syntax' do
      context 'with an array of values' do
        include_examples 'translations', :size,
                         small: 'Small', medium: 'Medium', large: 'Large'
      end

      context 'with a Hash of values' do
        include_examples 'translations', :color,
                         red: 'Red', blue: 'Violets are blue'
      end
    end
  end

  if ActiveRecord.gem_version >= '7'
    context 'with Rails >= 7 syntax' do
      context 'with an array of values' do
        include_examples 'translations', :shape,
                         square: 'Square',
                         circle: 'You spin me right round, baby',
                         triangle: 'Pointy boi'
      end

      context 'with a Hash of values' do
        include_examples 'translations', :direction,
                         north: 'Up?', south: 'South', east: 'East', west: 'West'
      end

      it_behaves_like 'multiple models using the same enum name',
                      :status,
                      { active: 'First Active', inactive: 'First Inactive' },
                      { pending: 'Second Pending', completed: 'Second Completed' }
    end
  end
end
