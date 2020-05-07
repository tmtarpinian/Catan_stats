ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

# configure :developlement do
#     set :database, 'sqlite3:db/database.db'
# end

task :console do
    Pry.start
end