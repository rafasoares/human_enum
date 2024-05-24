# frozen_string_literal: true

require 'active_record'

class TestModel < ActiveRecord::Base
  include HumanEnum

  if ActiveRecord.gem_version < '7.2'
    enum size: %i[small medium large],
         color: { red: 'ff0000', blue: '0000ff' }
  end

  if ActiveRecord.gem_version >= '7'
    enum :shape, %i[square circle triangle]
    enum :direction, { north: 'N', south: 'S', east: 'E', west: 'W' }
  end
end
