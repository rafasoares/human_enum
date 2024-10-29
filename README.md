# HumanEnum

This gem allows you to specify enum value translations in your I18n locale files like any other ActiveRecord attribute and adds helper methods to get humanized translations of enum values.

[![Tests](https://github.com/rafasoares/human_enum/actions/workflows/tests.yml/badge.svg)](https://github.com/rafasoares/human_enum/actions/workflows/tests.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/b1caef25c888cde6688e/maintainability)](https://codeclimate.com/github/rafasoares/human_enum/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/b1caef25c888cde6688e/test_coverage)](https://codeclimate.com/github/rafasoares/human_enum/test_coverage)

## Requirements

This gem only supports actively maintained versions of Ruby and Rails. Currently, that is:
* Ruby 3.1+
* Rails 6.1+

It may work with older versions, but it is not officially supported.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'human_enum'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install human_enum
```

## Usage

First, include the concern in your models.

```ruby
class MyModel < ApplicationRecord
  include HumanEnum
end
```

For convenience, you can add it to your `ApplicationRecord` to add the functionality to every model in your application. For models that don't declare `enum` attributes, no extra logic is called.

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include HumanEnum
end
```

Then declare your enums as you normally would:

```ruby
class MyModel < ApplicationRecord
  # For Rails 7+
  enum :model_type, %i[default special]

  # For Rails 6
  enum model_type: %i[default special]
end
```

And add the enum values to your locale files under the **pluralized** version of the enum attribute:

```yaml
en:
  activerecord:
    attributes:
      my_model:
        model_types:
          default: Default Type
          special: I am so special
```

Note: internally, `human_enum` uses the model's [`i18n_scope`](https://api.rubyonrails.org/classes/ActiveModel/Translation.html#method-i-i18n_scope), so any customizations to your model/I18n setup should be automatically picked up.

Finally, you can use the helper method `human_[enum_attribute_name]` whenever you need the translated/human version of the enum value:

```ruby
model = MyModel.new(model_type: :special)
puts model.human_model_type # "I am so special"
```

To get the translated list of all possible enum values (as a Hash), use the class method `human_[pluralized_enum_attribute_name]`:

```ruby
puts MyModel.human_model_types # "{default: 'Default Type', special: 'I am so special'}"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rafasoares/human_enum. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
