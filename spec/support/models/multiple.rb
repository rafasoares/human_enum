# frozen_string_literal: true

module Multiple
  class FirstModel < ActiveRecord::Base
    include HumanEnum

    enum scope: %i[user account project] if ActiveRecord.gem_version < '7.2'

    enum :status, { active: 0, inactive: 1 } if ActiveRecord.gem_version >= '7'
  end

  class SecondModel < ActiveRecord::Base
    include HumanEnum

    enum scope: %i[city state country] if ActiveRecord.gem_version < '7.2'

    enum :status, { pending: 0, completed: 1 } if ActiveRecord.gem_version >= '7'
  end
end
