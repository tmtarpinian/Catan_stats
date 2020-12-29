require 'spec_helper'

describe "Turns Controller" do

	def user_signup
		fill_in(:name, :with => "wilfred")
		fill_in(:email, :with => "wilfred@wilfred.com")
		fill_in(:password, :with => "wilfred")
		click_button 'submit'
	end

#   before do
# 		@game = Game.create(:name => game_name, :number_of_players => game_players_3, :user_id => user.id)
# 		@turn = Turn.create(:result => 5, :game_id => @game.id)
#   end

	describe "/games/:id/turns create action" do
		it 'allows an authenticated user to create a turn for a game instance' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			expect(Turn.count).to eq(0)
			visit '/games/1'
			page.select('5', from: 'result')
			click_button 'submit'
			expect(Turn.count).to eq(1)
			expect(Turn.first.result).to eq(5)
			expect(page.body).to include("Roll Result: #{Turn.first.result}")
		end
	end

	describe "/games/:id/turns delete action" do
		it 'allows an authenticated user to delate a turn for a game instance' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			Turn.create(:result => 5, :game_id => Game.first.id)
			Turn.create(:result => 7, :game_id => Game.first.id)
			expect(Turn.count).to eq(2)
			visit '/games/1'
			find('#delete-roll-1').click
			expect(Turn.count).to eq(1)
			expect(Turn.first.result).to eq(7)
		end

		it 'redirects to game show page after delating a turn for a game instance' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			Turn.create(:result => 5, :game_id => Game.first.id)
			Turn.create(:result => 7, :game_id => Game.first.id)
			expect(Turn.count).to eq(2)
			visit '/games/1'
			find('#delete-roll-1').click
			expect(current_path).to eq("/games/#{Game.first.id}")
		end
	end
end