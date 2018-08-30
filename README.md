# Statics

[![Gem](https://img.shields.io/gem/v/statics.svg?style=flat)](http://rubygems.org/gems/statics)
[![CircleCI](https://circleci.com/gh/pablocrivella/statics.svg?style=svg)](https://circleci.com/gh/pablocrivella/statics)
[![Maintainability](https://api.codeclimate.com/v1/badges/935822c7c481aa464186/maintainability)](https://codeclimate.com/github/pablocrivella/statics/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/935822c7c481aa464186/test_coverage)](https://codeclimate.com/github/pablocrivella/statics/test_coverage)

Base class and modules for static models.

Links:

  - [API Docs](https://www.rubydoc.info/gems/statics)
  - [Contributing](https://github.com/pablocrivella/statics/blob/master/CONTRIBUTING.md)
  - [Code of Conduct](https://github.com/pablocrivella/statics/blob/master/CODE_OF_CONDUCT.md)

## Requirements

1. [Ruby 2.5.0](https://www.ruby-lang.org)

## Installation

To install, run:

```
gem install statics
```

Or add the following to your Gemfile:

```
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

Copyright 2018 [Pablo Crivella](https://pablocrivella.me).
Read [LICENSE](LICENSE.md) for details.
