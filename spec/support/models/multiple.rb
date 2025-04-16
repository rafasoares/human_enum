# frozen_string_literal: true

module Multiple
  class FirstModel < ActiveRecord::Base
    include HumanEnum
    enum :status, { active: 0, inactive: 1 }
  end

  class SecondModel < ActiveRecord::Base
    include HumanEnum
    enum :status, { pending: 0, completed: 1 }
  end
end
