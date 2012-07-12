source 'http://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.6'

gem 'bootstrap-sass'
gem 'bcrypt-ruby'
gem 'simple-decorator'
gem 'thin'

# Model Enhancement
gem 'faker'

# Views Enhancement
## Cells are View Components for Rails. They look and feel like controllers. See https://github.com/apotonick/cells
gem 'cells'

# Authentication - Authorization
## Devise is a flexible authentication solution for Rails. See https://github.com/plataformatec/devise/
gem 'devise'

## CanCan is an authorization library for Ruby on Rails. See https://github.com/ryanb/cancan
gem 'cancan'



group :production do
  gem 'pg'
  gem 'sass-rails', '-> 3.1.4'
  gem 'compass'
end

#group :development, :test do
  #gem 'sqlite3'
#end

group :development do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'annotate', :git => 'git://github.com/jeremyolliver/annotate_models.git', :branch => 'rake_compatibility'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'spork'
  gem 'database_cleaner'

  gem 'factory_girl_rails'

  gem 'rb-fsevent', :require => false
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'best_in_place', git: 'git://github.com/gposton/best_in_place.git'
gem 'paperclip'
gem 'remotipart'