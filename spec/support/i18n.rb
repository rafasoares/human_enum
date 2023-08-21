# frozen_string_literal: true

RSpec.configure do |_config|
  locales_path = File.join(__dir__, 'locales', '*.{rb,yml}')

  I18n.load_path += Dir[locales_path]
  I18n.default_locale = :en
end
