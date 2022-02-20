# Nay

#### Lightweight and simple string templating library

[![Gem Version](https://badge.fury.io/rb/nay.svg)](https://badge.fury.io/rb/nay) [![Ruby Gem CI](https://github.com/mattruggio/nay/actions/workflows/rubygem.yml/badge.svg)](https://github.com/mattruggio/nay/actions/workflows/rubygem.yml) [![Maintainability](https://api.codeclimate.com/v1/badges/4703f8c46f94685afc29/maintainability)](https://codeclimate.com/github/mattruggio/nay/maintainability) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Supplies a simple interface for evaluating string templates with objects.

## Installation

To install through Rubygems:

````
gem install nay
````

You can also add this to your Gemfile using:

````
bundle add nay
````

## Examples

### Simple String-based Expression

````ruby
animal = {
  'animal' => {
    'speed' => 'quick',
    'type' => 'fox'
  }
}

string   = 'A << animal.speed >> << animal.type >> jumps over the fence!'
compiled = Nay.evaluate(string, animal)
````

This would set `compiled` to: `# yields: 'A quick fox jumps over the fence!'`

Notes:

* Tokens are passed through #[] method for the passed in object.  Any object providing a brackets interface will work.
* A valid token only contains the following characters: [a-zA-Z0-9_-]. If a token needs to contain something not in that list then qualify it with double quotes (i.e. `hello, << person."first name" >>`)

### More Complex Expressions

Expressions are not limited to just being a string.  Here are the basic heuristics:

* hash: then each key and value are recursively traversed
* array: then each entry is recursively traversed
* string: evaluated with parameters
* anything not a hash, array, or string: do nothing

An example of this would be a somewhat complicated object:

````ruby
object = {
  '<< id_key >>' => '<< id >>',
  'pets' => [
    '<< pets."pet 1" >>',
    '<< pets."pet 2" >>'
  ],
  zyx: :vut
}

parameters = {
  'id_key' => 'id',
  'id' => 123,
  'pets' => {
    'pet 1' => 'dog',
    'pet 2' => 'cat'
  },
  zyx: :vut
}

evaluated_object = Nay.evaluate(object, parameters)
````

In the above example evaluated_object would be equivalent to:

````ruby
{
  'id' => '123',
  'pets' => [
    'dog',
    'cat'
  ],
  zyx: :vut
}
````

Notes:

* A hash, hash key, and hash value are represented here
* An array with entries are represented here
* A non-string is represented here (as the zyx/vut key/value)

## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check nay.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:mattruggio/nay.git)
4. Navigate to the root folder (cd nay)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````bash
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````bash
bundle exec guard
````

Also, do not forget to run Rubocop:

````bash
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into main
2. Update `version.rb` using [semantic versioning](https://semver.org/)
3. Install dependencies: `bundle`
4. Update `CHANGELOG.md` with release notes
5. Commit & push main to remote and ensure CI builds main successfully
6. Run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Code of Conduct

Everyone interacting in this codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mattruggio/nay/blob/main/CODE_OF_CONDUCT.md).

## License

This project is MIT Licensed.
