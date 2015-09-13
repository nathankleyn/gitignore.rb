# gitignore.rb [![Build Status](https://travis-ci.org/nathankleyn/gitignore.rb.svg)](https://travis-ci.org/nathankleyn/gitignore.rb)

This is an implementation of `.gitignore` parsing and matching in Rust. Use this library if you want to check whether a given path would be excluded by a `.gitignore` file.

This library wraps [my Rust implementation of `.gitignore` semantics](https://github.com/nathankleyn/gitignore.rs) for performance.

## Usage

The Gem is called `gitignore_rb` and you can it is available via [RubyGems](https://rubygems.org/gems/gitignore_rb):

```sh
gem install gitignore_rb
```

## Examples

A simple example is as follows:

```ruby
require 'gitignore'

gi = GitIgnore.new('/path/to/.gitignore')
gi.included_files #=> ['foo', 'bar', 'lux/win', ...]
```
