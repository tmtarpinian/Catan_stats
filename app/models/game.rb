class Game < Activerecord::Base
    belongs_to :user
    has_many :games
end