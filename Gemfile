source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'bootstrap-sass', '3.3.6'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'carrierwave', '0.11.2'
gem 'dotenv-rails'
gem 'fog', '1.38.0'
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'mini_magick', '4.5.1'
gem 'mysql2'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'rails', '~> 5.0.2'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate', '3.1.0'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen'
  gem 'puma'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end
