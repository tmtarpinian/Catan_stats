source 'http://rubygems.org'

gem 'activerecord', '~> 4.2', '>= 4.2.6', :require => 'active_record'
gem 'bcrypt'
gem "pg", "~> 0.21"
gem 'rake'
gem 'require_all'
gem 'shotgun'
gem 'sinatra'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'thin'

group :test, :development do
  gem "pry"
  #comment out sqlite gem if using postgresql for test and development database
  gem 'sqlite3', '~> 1.3.6'
end


group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner'
  gem 'factory_bot'
end

