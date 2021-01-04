require 'spec_helper'

RSpec.describe User, type: :model do
	let(:user1){
			User.create(name: "Dirty Harry", email: "email@email.com", password: "password")
	}
	let(:user2){
			User.new(name: "Dirty Harry", email: "email@email.com", password: "password")
    }
	let(:game){
			Game.new(name: "Catan", number_of_players: 3)
	}

	context "validations" do 
		it "is invalid without a name" do 
			expect(User.create(name: nil, email: "email@email.com", password: "password")).to_not be_valid
		end
		it "is invalid without an email" do 
			expect(User.create(name: "Dirty Harry", email: nil, password: "password")).to_not be_valid
		end
		it "is invalid without a password" do 
			expect(User.create(name: "Dirty Harry", email: "email@email.com", password: nil)).to_not be_valid
		end
	end

  context "Attributes" do
    it "has a name" do 
      expect(user1.name).to eq("Dirty Harry")
    end 

    it "has an email" do 
      expect(user1.email).to eq("email@email.com")
    end

    it "has a password" do 
      expect(user1.password).to eq("password")
    end
	end

	context "Associations" do
		it "has many games" do
			user1.games << game
			expect(user1.games).to include(game)
		end
  end
end