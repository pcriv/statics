# Statics

[![Gem](https://img.shields.io/gem/v/statics.svg?style=flat)](http://rubygems.org/gems/statics)
[![Depfu](https://badges.depfu.com/badges/6f2f73672eae4d603d6ae923164435e2/overview.svg)](https://depfu.com/github/pcriv/statics?project=Bundler)
[![Inline docs](http://inch-ci.org/github/pcriv/statics.svg?branch=master&style=shields)](http://inch-ci.org/github/pcriv/statics)
[![Maintainability](https://api.codeclimate.com/v1/badges/935822c7c481aa464186/maintainability)](https://codeclimate.com/github/pcriv/statics/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/935822c7c481aa464186/test_coverage)](https://codeclimate.com/github/pcriv/statics/test_coverage)

Base class and modules for static models.

Links:

- [API Docs](https://www.rubydoc.info/gems/statics)
- [Contributing](https://github.com/pcriv/statics/blob/master/CONTRIBUTING.md)
- [Code of Conduct](https://github.com/pcriv/statics/blob/master/CODE_OF_CONDUCT.md)

## Requirements

1. [Ruby 3.0.0](https://www.ruby-lang.org)

## Installation

To install, run:

```sh
gem install statics
```

Or add the following to your Gemfile:

```sh
gem "statics"
```

## Usage

Setting the data path:

```ruby
Statics.configure do |config|
  config.data_path = "data/"
end
```

Defining a static model:

```ruby
class Post < Statics::Model
  filename "posts"

  attribute :title, Types::Strict::String
end
```

```yml
# data/posts.yml
---
post1:
  title: "Post 1"

post2:
  title: "Post 2"
```

```ruby
Post.all
#=> #<Statics::Collection records=[#<Post key=:post1 title="Post 1">, #<Post key=:post2 title="Post 2">]>
Post.where(title: "Post 1")
#=> #<Statics::Collection records=[#<Post key=:post1 title="Post 1">]>
Post.where_not(title: "Post 1")
#=> #<Statics::Collection records=[#<Post key=:post2 title="Post 2">]>
Post.find_by(key: :post1)
#=> #<Post key=:post1 title="Post 1">
Post[:post1]
#=> #<Post key=:post1 title="Post 1">
Post.pluck(:title)
#=> ["Post 1", "Post 2"]
post = Post.first
#=> #<Post key=:post1 title="Post 1">
post.key
#=> :post1
post.title
#=> "Post 1"
post.attributes
#=> {:title=>"Post 1", :key=>:post1}
```

Defining translatable attributes:

```ruby
class Post < Statics::Model
  include Statics::Translatable

  filename "posts"

  attribute :title, Types::Strict::String
  translatable_attribute :body
end
```

```yml
# data/posts.yml
---
post1:
  title: "Post 1"
  body:
    en: "Hello!"
    nl: "Hallo!"

post2:
  title: "Post 2"
  body:
    en: "Bye!"
    nl: "Doei!"
```

```ruby
post = Post.first
# when I18n.locale is :en
post.body #=> "Hello!"
post.body(locale: :nl) #=> "Hallo!"
```

Defining omittable attributes with defaults:

```ruby
class Post < Statics::Model
  include Statics::Translatable

  filename "posts"

  attribute :title, Types::Strict::String
  # With default
  attribute? :author, Types::Strict::String.default("Unknown")
  # Without default
  # attribute? :author, Types::Strict::String
end
```

```yml
# data/posts.yml
---
post1:
  title: "Post 1"
  author: "Rick Sanchez"

post2:
  title: "Post 2"
```

```ruby
post1 = Post.first
post1.author #=> "Rick Sanchez"
post2 = Post.last
post2.author #=> "Unknown"
```

Check [dry-types](https://dry-rb.org/gems/dry-types) for documentation about the [built-in types](https://dry-rb.org/gems/dry-types/built-in-types/).

## Caveats

If you have dates in your yaml-files, use the following format for them to be handled properly: `YYYY-MM-DD`

## Tests

To test, run:

```
bundle exec rspec spec/
```

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## License

Copyright 2018 [Pablo Crivella](https://pcriv.com).
Read [LICENSE](LICENSE) for details.
