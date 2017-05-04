# HumanEnum

This gem allows you to specify enum value translations like any other ActiveRecord attrubute and adds helper methods to get humanized translations of enum values

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'human_enum'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install human_enum

## Usage

First, include the concern in your models:

```ruby
class MyModel < ApplicationRecord
  include HumanEnum
end
```

Alternativelly, add it to your `ApplicationRecord` to add the functionality to every model in your application:

```ruby
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include HumanEnum
end
```

Declare your enums as you normally would:

```ruby
class MyModel < ApplicationRecord
  enum model_type: [:default, :special]
end
```

And add the enum values to your locale files under the pluralized version of the enum attribute:

```yaml
en:
  activerecord:
    attributes:
      my_model:
        model_types:
          default: Default Type
          special: I am so special
```

Then, you can use the helper method `human_[enum_attribute_name]` whenever you need the translated / humanized version of the enum value:

```ruby
model = MyModel.new model_type: :special
puts model.human_model_type # "I am so special"
```

To get the translated list of all possible enum values (as a Hash), use the class method `human_[pluralized_enum_attribute_name]`:

```ruby
puts MyModel.human_model_types # "{default: 'Default Type', special: 'I am so special'}"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rafasoares/human_enum. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

