# frozen_string_literal: true

require 'human_enum/version'
require 'active_support/concern'
require 'active_support/core_ext/array'
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

  class_methods do
    def enum(name = nil, values = nil, **options)
      super

      if name.nil?
        name = options.keys.reject { |key, _| key.start_with? '_'}.first
      end

      humanize = lambda do |name, value, scope, ancestors|
        attributes_scope = "#{scope}.attributes"
        enum_key = value ? "#{name.to_s.pluralize}.#{value}" : name.to_s.pluralize

        defaults = ancestors.map do |klass|
          :"#{attributes_scope}.#{klass.model_name.i18n_key}.#{enum_key}"
        end

        defaults << :"attributes.#{enum_key}"
        defaults << value.to_s.humanize

        I18n.translate defaults.shift, default: defaults
      end

      define_method "human_#{name}" do
        value = send name
        humanize.call name, value, self.class.i18n_scope, self.class.lookup_ancestors unless value.nil?
      end

      collection_name = name.to_s.pluralize
      self.class.send :define_method, "human_#{collection_name}" do
        humanize.call name, nil, i18n_scope, lookup_ancestors
      end
    end
  end
end
