class Turn < Activerecord::Base
    belongs_to :game
    belongs_to :user, through :game
end