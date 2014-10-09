source 'https://rubygems.org'

ruby '2.1.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

gem 'foreman'

gem 'puma'

# Application monitoring
gem 'newrelic_rpm'

gem 'rmagick'
gem 'sidekiq', '3.2.5', require: 'sidekiq/web'

# if you require 'sinatra' you get the DSL extended to Object
gem 'sinatra', '>= 1.3.0', :require => nil

gem 'haml-rails'

# Protect against bruteforcing
gem 'rack-attack'

gem 'bootstrap-sass', '~> 3.0'
gem 'font-awesome-rails', '~> 4.2'

gem 'messengerjs-rails', '~> 1.4.1'
gem 'nprogress-rails'
gem 'animate-rails'
gem 'jquery-scrollto-rails'
gem 'jquery-easing-rails'

gem 'redcarpet'

# Resources
gem 'inherited_resources'
gem 'has_scope'
gem 'kaminari'

gem 'tubesock'

gem 'jquery-validation-rails'

gem 'aws-sdk', '~> 1.33.0'
gem 'colorize', require: nil

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', require: false
  gem 'sextant'
  gem 'quiet_assets'
  gem 'annotate', '>=2.6.0'
  gem 'figaro'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'letter_opener'
  gem 'rails_best_practices'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :production do
  gem 'rails_12factor'
  gem 'heroku-deflater'
  gem 'pg'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara', '~> 2.2.1'
  gem 'pry'
  gem 'awesome_print'
  gem 'launchy'
  gem 'factory_girl_rails'

  gem 'minitest'

  # Generate Fake data
  gem 'ffaker'
end

group :test do
  gem 'simplecov', require: false
  gem 'shoulda-matchers', '~> 2.1.0'
  gem 'email_spec'
  gem 'webmock'
  gem 'test_after_commit'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

