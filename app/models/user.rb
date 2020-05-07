class User < Activerecord:Base
    has_many :games
    has_many :turns, through :games
end