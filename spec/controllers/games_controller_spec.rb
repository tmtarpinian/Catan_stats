require 'spec_helper'

describe "Games Controller" do

	def user_signup
		fill_in(:name, :with => "wilfred")
		fill_in(:email, :with => "wilfred@wilfred.com")
		fill_in(:password, :with => "wilfred")
		click_button 'submit'
	end

	describe "/games index action" do

		it '/games responds with a 200 status code' do
			visit '/signup'
			user_signup
			visit '/games'
			expect(page.status_code).to eq(200)
		end

		it 'authenticated users can access /games' do
			visit '/signup'
			user_signup
			visit '/games'
			expect(current_path).to eq('/games')
			expect(page).to have_content("#{User.first.name}'s Games")
		end

		it 'only authenticated users can access /games' do
			visit '/games'
			expect(current_path).to eq('/login')
		end
	end

	describe "/games/:id show action" do

		it '/games/:id responds with a 200 status code' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			visit '/games/1'
			expect(page.status_code).to eq(200)
		end

		it 'authenticated users can access an individual game' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			visit '/games/1'
			expect(current_path).to eq('/games/1')
			expect(page).to have_content("Game: #{Game.first.name}")
		end

		it 'only authenticated users can access an individual game' do
			User.create(:name => "wilfred", :email => "wilfred@wilfred.com", :password => "wilfred")
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			visit '/games/1'
			expect(current_path).to eq('/login')
		end
	end

	describe "/games/ new action" do

		it '/games/new responds with a 200 status code' do
			visit '/signup'
			user_signup
			visit '/games/new'
			expect(page.status_code).to eq(200)
		end

		it 'authenticated users can access new game page' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			visit '/games/new'
			expect(current_path).to eq('/games/new')
			expect(page).to have_content("What is the Title of Your New Game?")
		end

		it 'restricts new game page access to authenticated users only' do
			visit '/games/new'
			expect(current_path).to eq('/login')
		end
	end

	describe "/games/ create action" do

		it 'allows authenticated users to successfully create a new game instance' do
			visit '/signup'
			user_signup
			visit '/games/new'
			page.select("Catan", from: 'name')
			page.select(4, from: 'players')
			click_button 'submit'
			expect(Game.first.name).to eq('Catan')
			expect(Game.first.number_of_players).to eq(4)
		end

		it 'redirects to game show page after instantiation of new game' do
			visit '/signup'
			user_signup
			visit '/games/new'
			page.select("Catan", from: 'name')
			page.select(4, from: 'players')
			click_button 'submit'
			expect(current_path).to eq("/games/#{Game.first.id}")
			expect(page).to have_content("Game: #{Game.first.name}")
		end
	end

	describe "/games/:id/edit edit action" do

		it '/games/:id/edit responds with a 200 status code' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			visit "/games/#{Game.first.id}/edit"
			expect(page.status_code).to eq(200)
		end

		it 'authenticated users can access edit game page' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			visit "/games/#{Game.first.id}/edit"
			expect(current_path).to eq('/games/1/edit')
			expect(page).to have_content("Change the Status of This Game")
		end

		it 'restricts edit game page access to authenticated users only' do
			Game.create(user_id: 1, number_of_players: 4, name: "Catan")
			visit '/games/1'
			expect(current_path).to eq('/login')
		end

		it 'restricts edit game page to valid games only' do
			visit '/signup'
			user_signup
			visit '/games/65/edit'
			expect(current_path).to eq('/games')
		end
	
		it 'restricts edit game page to only games of logged in user' do
			visit '/signup'
			user_signup
			game_1 = Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			game_2 = Game.create(user_id: 2, number_of_players: 4, name: "Catan")
			visit '/games/1/edit'
			expect(current_path).to eq('/games/1/edit')
			visit '/games/2/edit'
			expect(current_path).to eq('/games')
		end
	end

	describe "/games/:id patch action" do

		it 'allows authenticated users to successfully edit a game instance' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			visit "/games/#{Game.first.id}/edit"
			page.select('Finished', from: 'status')
			click_button 'submit'
			expect(Game.first.name).to eq('Catan')
			expect(Game.first.status).to eq("Finished")
		end

		it 'redirects to game show page after updating a game' do
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			visit "/games/#{Game.first.id}/edit"
			page.select('Finished', from: 'status')
			click_button 'submit'
			expect(current_path).to eq("/games/#{Game.first.id}")
			expect(page).to have_content("Game: #{Game.first.name}")
		end
	end

		# describe "/games/:id delete action" do								<--- deleted feature to reformat styling
		# 	it 'allows an authenticated user to delete a game instance' do
		# 		visit '/signup'
		# 		user_signup
		# 		Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
		# 		expect(Game.count).to eq(1)
		# 		visit "/games/#{Game.first.id}"
		# 		click_button 'Delete Game'
		# 		expect(page.status_code).to eq(200)
		# 		expect(Game.count).to eq(0)
		# 	end
	
		# 	it 'delete action redirects to root route for authenticated users' do
		# 		visit '/signup'
		# 		user_signup
		# 		Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
		# 		expect(Game.count).to eq(1)
		# 		visit "/games/#{Game.first.id}"
		# 		click_button 'Delete Game'
		# 		expect(current_path).to eq('/games')
		# 	end
		# end
end