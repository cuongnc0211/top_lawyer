source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem "closure_tree"
gem "bootstrap-sass"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem "pry-rails"
  gem "rspec"
  gem "rspec-rails"
  gem "factory_bot_rails"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
end

group :staging, :production do
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-rails"
  gem "capistrano-rvm"
  gem "capistrano-faster-assets", "~> 1.0"
  gem "capistrano-sidekiq"
  gem "capistrano-passenger"
  gem "capistrano3-puma"
  gem "capistrano-maintenance", "~> 1.0", require: false
  gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "pundit"
gem "config"
gem "kaminari"
gem "devise"
gem "ransack"
gem "ckeditor", github: 'galetahub/ckeditor', ref: '11d3a5b'
gem "fog-aws"
gem "figaro"
# gem "mysql2"
gem 'pg'
gem "carrierwave"
gem "mini_magick"
gem "faker"
gem "jquery-rails"
gem "nested_form"
gem "momentjs-rails", ">= 2.9.0"
gem "bootstrap3-datetimepicker-rails", "~> 4.17.47"
gem "draper"
gem "fog-aws"
gem "aws-sdk", "~> 3"
gem "fog"
gem "asset_sync"
gem "acts-as-taggable-on"
gem "gon"
gem 'impressionist', '~>1.6.1'
gem "wicked"
gem "unicorn"

#captcha

gem 'dotenv-rails', :require => 'dotenv/rails-now'

gem "recaptcha", require: "recaptcha/rails"
