# Ogpr

[![CircleCI](https://circleci.com/gh/hirakiuc/ogpr.svg?style=shield&circle-token=332a902a7ec2815346b303dd1aebe68b44ce0ced)](https://circleci.com/gh/hirakiuc/ogpr)
[![Maintainability](https://api.codeclimate.com/v1/badges/4e0e0aa416b417195cef/maintainability)](https://codeclimate.com/github/hirakiuc/ogpr/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4e0e0aa416b417195cef/test_coverage)](https://codeclimate.com/github/hirakiuc/ogpr/test_coverage)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/hirakiuc/ogpr/master)

a ruby library to fetch and parse meta tags which represent OpenGraph Protocol.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ogpr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ogpr

## Usage

```ruby
require "ogpr"

# Fetch and parse meta tags from the url
ogp = Ogpr.fetch("http://example.com/path/to/page")
# Parse the string as meta tags.
ogp = Ogpr.parse("<meta ....>")

# Fetch OpenGraph meta tag
og = ogp.open_graph
if og
  og.each_pair do |k, v|
    puts "#{k} => #{v}"
  end
end

# Fetch TwitterCard meta tag
card = ogp.twitter_card
if card
  card.each_pair do |k,v|
    puts "#{k} => #{v}"
  end
end

# Fetch all of OpenGraph and TwitterCard meta tag
if ogp.exist?
  ogp.title       # og:title or twitter:title
  ogp.type        # og:type or twitter:card
  ogp.description # og:description or twitter:description
  ogp.image       # og:image or twitter:image
  ogp.url         # og:url or twitter:url
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hirakiuc/ogpr.
