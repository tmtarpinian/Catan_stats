require 'simplecov'
SimpleCov.start

# require 'shields_badge'
# SimpleCov.formatter = SimpleCov::Formatter::ShieldsBadge


ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

ActiveRecord::Base.logger = nil

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods
  config.include Capybara::DSL
  #config.include LoginHelper, :type => :feature
  DatabaseCleaner.strategy = :truncation

  config.before do
    DatabaseCleaner.clean
  end

  config.after do
    DatabaseCleaner.clean
  end

  #config.order = :random
  Kernel.srand config.seed
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app