# Capybara PageMapper
[![Build Status](https://travis-ci.org/3zcurdia/capybara-page_mapper.svg?branch=master)](https://travis-ci.org/3zcurdia/capybara-page_mapper)
[![Gem Version](https://badge.fury.io/rb/capybara-page_mapper.svg)](https://badge.fury.io/rb/capybara-page_mapper)

Simple object mapper for page objects with capybara

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capybara-page_mapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capybara-page_mapper

## Usage

Inherit from ```Capybara::PageMapper::Base``` and define the input fields as the following example

```ruby
class LoginPage < Capybara::PageMapper::Base
  define_input :email, '//*[@id="user_email"]'
  define_input :password, '//*[@id="user_password"]'
  define_button :log_in, '//*[@id="log_in"]'
end
```
Once you have define your input you will have access to the getters setters

```ruby
login_page = LoginPage.new
login_page.email = "test@example.org"
login_page.email
# => "test@example.org"
login_page.email_input
# => Capybara::Node
login_page.log_in_button.click if login_page.valid?
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/3zcurdia/capybara-page_mapper.
