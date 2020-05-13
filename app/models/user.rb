class User < ActiveRecord::Base
    has_secure_password
    has_many :games
    has_many :turns, through: :games

    validates :name, :email, :password, presence: true
end