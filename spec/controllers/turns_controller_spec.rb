require 'spec_helper'

describe "Turns Controller" do

	def user_signup
		fill_in(:name, :with => "wilfred")
		fill_in(:email, :with => "wilfred@wilfred.com")
		fill_in(:password, :with => "wilfred")
		click_button 'submit'
	end

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

	describe "/games/:id/turns/:id/edit edit action" do

		it '/games/:id/turns/:id/edit responds with a 200 status code' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			Turn.create(:result => 5, :game_id => Game.first.id)
			visit "/games/#{Game.first.id}/turns/#{Turn.first.id}/edit"
			expect(page.status_code).to eq(200)
		end

		it 'authenticated users can access edit turn page' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			Turn.create(:result => 5, :game_id => Game.first.id)
			visit "/games/#{Game.first.id}/turns/#{Turn.first.id}/edit"
			expect(current_path).to eq('/games/1/turns/1/edit')
			expect(page).to have_content("Edit Your Turn Result Here:")
		end

		it 'restricts edit turn page access to authenticated users only' do
			Game.create(user_id: 1, number_of_players: 4, name: "Catan")
			Turn.create(:result => 5, :game_id => Game.first.id)
			visit '/games/1/turns/1/edit'
			expect(current_path).to eq('/login')
		end

		it 'restricts edit turn page to valid turns only' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			visit '/games/1'
			visit '/games/1/turns/34/edit'
			expect(current_path).to eq('/games/1')
		end
	
		it 'restricts edit turn page to only games of logged in user' do
			visit '/signup'
			user_signup
			game_1 = Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			game_2 = Game.create(user_id: 2, number_of_players: 4, name: "Catan")
			Turn.create(:result => 5, :game_id => Game.first.id)
			Turn.create(:result => 5, :game_id => Game.last.id)
			visit '/games/1/turns/1/edit'
			expect(current_path).to eq('/games/1/turns/1/edit')
			visit '/games/2/turns/2/edit'
			expect(current_path).to eq('/games')
		end
	end

	describe "/games/:id/turns/:id patch action" do

		it 'allows authenticated users to successfully edit a turn instance' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			Turn.create(:result => 5, :game_id => Game.first.id)
			visit "/games/#{Game.first.id}/turns/#{Turn.first.id}/edit"
			page.select(7, from: 'result')
			click_button 'submit'
			expect(Turn.first.result).to eq(7)
		end

		it 'redirects to game show page after updating a turn' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			Turn.create(:result => 5, :game_id => Game.first.id)
			visit "/games/#{Game.first.id}/turns/#{Turn.first.id}/edit"
			page.select(7, from: 'result')
			click_button 'submit'
			expect(current_path).to eq("/games/#{Game.first.id}")
			expect(page).to have_content("Game: #{Game.first.name}")
		end
	end
end