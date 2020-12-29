require 'spec_helper'

describe "Games Controller" do

	def user_signup
		fill_in(:name, :with => "wilfred")
		fill_in(:email, :with => "wilfred@wilfred.com")
		fill_in(:password, :with => "wilfred")
		click_button 'submit'
	end

	# Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
	# Turn.create(game_id: Game.first.id, result: 4)
	# Turn.create(game_id: Game.first.id, result: 7)

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
			# select values instead of relying on the default page fill
			# find('#organizationSelect').find(:xpath, 'option[1]').select_option
			# select(:name, :with => "Catan")
			# select(:players, :with => 4)
			click_button 'submit'
			expect(Game.first.name).to eq('Catan')
			expect(Game.first.number_of_players).to eq(3)
		end

		it 'redirects to game show page after instantiation of new game' do
			visit '/signup'
			user_signup
			visit '/games/new'
			# select values instead of relying on the default page fill
			# find('#organizationSelect').find(:xpath, 'option[1]').select_option
			# select(:name, :with => "Catan")
			# select(:players, :with => 4)
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

		it 'restricts new game page access to authenticated users only' do
			Game.create(user_id: 1, number_of_players: 4, name: "Catan")
			visit '/games/1'
			expect(current_path).to eq('/login')
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

		it 'redirects to game show page after instantiation of new game' do
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
	
		describe "/games/:id delete action" do
			it 'allows an authenticated user to delete a game instance' do
				visit '/signup'
				user_signup
				Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
				expect(Game.count).to eq(1)
				visit "/games/#{Game.first.id}"
				click_button 'Delete Game'
				expect(page.status_code).to eq(200)
				expect(Game.count).to eq(0)
			end
	
			it 'delete action redirects to root route for authenticated users' do
				visit '/signup'
				user_signup
				Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
				expect(Game.count).to eq(1)
				visit "/games/#{Game.first.id}"
				click_button 'Delete Game'
				expect(current_path).to eq('/games')
			end

	end

	

		# visit '/signup'
		# visit '/signup'
		# user_signup
		# Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
		# Turn.create(game_id: Game.first.id, result: 4)
		# Turn.create(game_id: Game.first.id, result: 7)
		# expect(User.count).to eq(1)
		# expect(Game.count).to eq(1)
		# expect(Turn.count).to eq(2)
		# visit '/users/edit'
		# click_button 'Delete User'
  		# expect(page.status_code).to eq(200)
		# expect(User.count).to eq(0)
		# expect(Game.count).to eq(0)
		# expect(Turn.count).to eq(0)

		# it "contains links to each game's show page" do
			
		# 	all_link_hrefs = page.all(:css, "a[href]").map do |element| 
		# 		binding.pry
		# 		element[:href] 
		# 	end
		# 	expect(all_link_hrefs).to include("/games/#{@game1.id}")
		# 	expect(all_link_hrefs).to include("/games/#{@game2.id}")
		# end
	



    # it "contains a form to delete the game" do
    #   expect(page.find(:css, "form")[:action]).to eq("/games/#{@game_1.id}")
    # end

    # it 'deletes via a DELETE request' do
    #   expect(page.find(:css, "form input[name=_method]", :visible => false)[:value]).to match(/delete/i)
    # end
end