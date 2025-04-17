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

      include_examples 'multiple models',
                       :scope,
                       first: { user: 'User scope', account: 'Account scope', project: 'Project scope' },
                       second: { city: 'City scope', state: 'State scope', country: 'Country scope' }
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

      include_examples 'multiple models',
                       :status,
                       first: { active: 'First Active', inactive: 'First Inactive' },
                       second: { pending: 'Second Pending', completed: 'Second Completed' }
    end
  end
end
