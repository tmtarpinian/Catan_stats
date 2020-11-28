require 'spec_helper'

RSpec.describe Game, type: :model do
	let(:user1){
			User.create(name: "Dirty Harry", email: "email@email.com", password: "password")
	}
	let(:game){
						Game.create(user_id: user1.id, name: "Catan", number_of_players: 3)
	}

  context "Attributes" do
    it "has a name" do 
      expect(game.name).to eq("Catan")
    end 

    it "has players" do 
      expect(game.number_of_players).to eq(3)
    end

    it "has a gamedate" do 
      expect(game.gamedate.strftime("%Y%m%d")).to eq("20201111")
		end

		it "has a status" do 
			expect(game.status).to eq("In Progress")
		end
	end

	context "Associations" do
		it "belongs to a user" do
			expect(user1.games).to include(game)
			expect(game.user_id).to eq(user1.id)
		end
  end
end