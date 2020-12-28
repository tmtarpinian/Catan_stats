class User < ActiveRecord::Base
    has_secure_password
    has_many :games, dependent: :destroy
    has_many :turns, through: :games, dependent: :destroy

    validates :name, :email, presence: true
    validates :email, uniqueness: true
end