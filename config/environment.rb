require 'bundler/setup'
Bundler.require

configure :test do
  ENV['SINATRA_ENV'] ||= "test"

  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
end

configure :development do
  ENV['SINATRA_ENV'] ||= "development"

  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
end

# configure :production do
# 	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/catan')

# 	ActiveRecord::Base.establish_connection(
# 			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
# 			:host     => db.host,
# 			:username => db.user,
# 			:password => db.password,
# 			:database => db.path[1..-1],
# 			:encoding => 'unicode'
# 	)
# end

require_all 'app'
