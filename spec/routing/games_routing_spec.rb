require 'spec_helper'
require_relative './support/login_helper'

describe "Games Routes" do
	let(:user_1) {User.create(name: "Dirty Harry", email: "email@email.com", password: "password")}
  let(:game_name) { "Catan" }
	let(:game_players_3) { 3 }
	let(:game_players_4) { 4 }

  before do
		@game_1 = Game.create(:name => game_name, :number_of_players => game_players_3, :user_id => user_1.id)
		@game_2 = Game.create(:name => game_name, :number_of_players => game_players_4, :user_id => user_1.id)
  end

	describe "Index page '/games'" do

		before do
			visit "/games"
		end

		it 'responds with a 200 status code' do
			expect(page.status_code).to eq(200)
		end

		it "displays a list of games" do
			expect(page.body).to include(game_name)
			expect(page.body).to include(@game_2.name)
		end

		# it "contains links to each game's show page" do
			
		# 	all_link_hrefs = page.all(:css, "a[href]").map do |element| 
		# 		binding.pry
		# 		element[:href] 
		# 	end
		# 	expect(all_link_hrefs).to include("/games/#{@game1.id}")
		# 	expect(all_link_hrefs).to include("/games/#{@game2.id}")
		# end
	end

	describe "show page '/games/:id'" do
    before do
      visit "/games/#{@game_1.id}"
    end

    it 'responds with a 200 status code' do
      expect(page.status_code).to eq(200)
    end

    it "displays the game's name" do
      expect(page.body).to include(@game_1.name)
    end

    it "displays the game's date" do
      expect(page.body).to include(@game_1.gamedate.to_s)
    end

    it "displays the game's status" do
      expect(page.body).to include(@game_1.status)
		end
		
		# it "displays the game's rolls" do
		# 		# 	all_link_hrefs = page.all(:css, "a[href]").map do |element| 
		# # 		binding.pry
		# # 		element[:href] 
		# # 	end
		# # 	expect(all_link_hrefs).to include("/games/#{@game1.id}")
		# # 	expect(all_link_hrefs).to include("/games/#{@game2.id}")
    # end

    # it "contains a form to delete the game" do
    #   expect(page.find(:css, "form")[:action]).to eq("/games/#{@game_1.id}")
    # end

    # it 'deletes via a DELETE request' do
    #   expect(page.find(:css, "form input[name=_method]", :visible => false)[:value]).to match(/delete/i)
    # end
  end
end