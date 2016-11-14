add_source 'https://rubygems.org'
gem 'rails', '~> 5.0'
gem 'pg'
gem 'puma'
gem 'redis'

gem 'bootstrap-sass'
gem 'sass-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'uglifier'
gem 'coffee-rails'

gem 'simple_form'

gem 'turbolinks'
gem 'jbuilder'

gem_group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails'
  gem 'dotenv-rails'
end

gem_group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
