# frozen_string_literal: true

require 'human_enum/version'
require 'active_support'
require 'active_support/concern'
require 'active_support/core_ext/array'
require 'active_support/core_ext/module/deprecation'
require 'active_model/naming'
require 'active_model/translation'
require 'active_record/type'
require 'active_record/enum'

# # About Human Enum
# Human Enum allows you to easily translate `enum` values in [ActiveRecord]
# models

# [ActiveRecord]: https://api.rubyonrails.org/v5.2.3/classes/ActiveRecord/Enum.html
module HumanEnum
  class Error < StandardError; end

  extend ActiveSupport::Concern

  class << self
    def deprecator = @deprecator ||= ActiveSupport::Deprecation.new('2.0', 'HumanEnum')
  end

  included do
    # DEPRECATED: This method is deprecated and will be removed in future versions.
    #
    # Returns the human-readable value of the specified enum.
    #
    # @param enum_name [Symbol] The name of the enum.
    # @return [String] The human-readable value of the enum.
    # @deprecated Use `human_<enum_name>` instead.
    # :nocov:
    def human_enum_value(enum_name, enum_value)
      _translate_enum(enum_name, enum_value)
    end
    # :nocov:

    deprecate(human_enum_value: 'use `human_<enum_name>` instead', deprecator: HumanEnum.deprecator)

    private

    def _translate_enum(enum_name, enum_value = send(enum_name))
      self.class.send(:_translate_enum, enum_name, enum_value)
    end
  end

  class_methods do # rubocop:disable Metrics/BlockLength
    def enum(...)
      super.tap { humanize_enums }
    end

    # DEPRECATED: This method is deprecated and will be removed in future versions.
    #
    # Translates the given enum value into a human-readable string.
    #
    # @param enum_name [Symbol] The name of the enum.
    # @param enum_value [Symbol] The value of the enum.
    # @return [String] The human-readable string representation of the enum value.
    # @deprecated Use `human_<plural_enum_name>` instead.
    # :nocov:
    def human_enum_value(enum_name, enum_value)
      _translate_enum(enum_name, enum_value)
    end
    # :nocov:

    deprecate(human_enum_value: 'use `human_<plural_enum_name>` instead', deprecator: HumanEnum.deprecator)

    # Goes through all enums defined in the model and creates the necessary methods, if they don't exist yet.
    def humanize_enums
      defined_enums.each do |enum_name, values|
        _define_instance_method(enum_name)
        _define_class_method(enum_name, values)
      end
    end

    private

    def _translate_enum(enum_name, enum_value)
      attributes_scope = "#{i18n_scope}.attributes"
      enum_key = [enum_name.to_s.pluralize, enum_value].compact.join('.')

      defaults = lookup_ancestors.map do |klass|
        :"#{attributes_scope}.#{klass.model_name.i18n_key}.#{enum_key}"
      end

      defaults << :"attributes.#{enum_key}"
      defaults << enum_value.to_s.humanize

      I18n.t defaults.shift, default: defaults
    end

    def _define_instance_method(enum_name)
      return if method_defined?(:"human_#{enum_name}")

      define_method(:"human_#{enum_name}") do
        _translate_enum(enum_name, send(enum_name))
      end
    end

    def _define_class_method(enum_name, values)
      collection_name = enum_name.to_s.pluralize
      return if respond_to?(:"human_#{collection_name}")

      define_singleton_method :"human_#{collection_name}" do
        values.to_h { |key, _| [key.to_sym, _translate_enum(enum_name, key)] }
      end
    end
  end
end
