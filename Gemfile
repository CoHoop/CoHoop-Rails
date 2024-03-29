source 'http://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.6'

gem 'bootstrap-sass'
gem 'bcrypt-ruby'
gem 'simple-decorator'
gem 'thin'

# Model Enhancement
gem 'ffaker'

# Views Enhancement
## Cells are View Components for Rails. They look and feel like controllers. See https://github.com/apotonick/cells
gem 'cells'

# Authentication - Authorization
## Devise is a flexible authentication solution for Rails. See https://github.com/plataformatec/devise/
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'

## CanCan is an authorization library for Ruby on Rails. See https://github.com/ryanb/cancan
gem 'cancan'

## Pagination
#gem 'kaminari'
gem 'will_paginate', '~> 3.0'

## String extension
gem 'stringex'

# Tag extraction
gem 'tag-extractor'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
end

group :development do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'annotate', :git => 'git://github.com/jeremyolliver/annotate_models.git', :branch => 'rake_compatibility'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'spork'
  gem 'database_cleaner'

  gem 'factory_girl_rails'

  gem 'rb-fsevent', :require => false
end

group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'uglifier',   '>= 1.0.3'
end

gem 'jquery-rails'
gem 'best_in_place'
gem 'rmagick'
gem 'paperclip'
gem 'remotipart', git: 'git://github.com/JangoSteve/remotipart.git'
gem 'awesome_print', :require => 'ap'
gem 'rails3-jquery-autocomplete', git: 'git://github.com/gabriel-dehan/rails3-jquery-autocomplete.git'
