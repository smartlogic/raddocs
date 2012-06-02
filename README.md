[![Travis status](https://secure.travis-ci.org/oestrich/raddocs.png)](https://secure.travis-ci.org/oestrich/raddocs)


# Raddocs

Raddocs is a browser for JSON outputted by the [rspec_api_documentation](http://github.com/zipmark/rspec_api_documentation) gem.

## Install

`Gemfile`
```ruby
gem 'raddocs'
```

`config/routes.rb`

```ruby
  match "/docs" => Raddocs::App, :anchor => false
```

## Configuration
* docs_dir       - where the JSON output from rspec_api_documentation is located
* docs_mime_type - if you use the middleware, what mime type are you serving your docs as, must be a regex. eg: `/text\/vnd.org.oestrich.raddocs\+plain/`