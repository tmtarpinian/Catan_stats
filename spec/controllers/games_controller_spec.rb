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
			visit '/games/1'
			expect(current_path).to eq('/login')
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
	end



    # it "contains a form to delete the game" do
    #   expect(page.find(:css, "form")[:action]).to eq("/games/#{@game_1.id}")
    # end

    # it 'deletes via a DELETE request' do
    #   expect(page.find(:css, "form input[name=_method]", :visible => false)[:value]).to match(/delete/i)
    # end
  end
end