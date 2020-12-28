require 'spec_helper'

describe 'User Controller', type: :feature do

	def user_signup
		fill_in(:name, :with => "wilfred")
		fill_in(:email, :with => "wilfred@wilfred.com")
		fill_in(:password, :with => "wilfred")
		click_button 'submit'
	end

	def user_signin
		fill_in(:email, :with => "wilfred@wilfred.com")
		fill_in(:password, :with => "wilfred")
		click_button 'submit'
	end

	context "/signup action" do
	

		it "renders signup page successfully" do
			visit '/signup'
			expect(page.status_code).to eq(200)
		end

		it 'successful signup redirects to profile' do
			visit '/signup'
			expect(current_path).to eq('/signup')
			user_signup
			expect(current_path).to eq('/profile')
			expect(page).to have_content("wilfred")
		end

		it 'unsuccessful signup re-renders signup page' do
			visit '/signup'
			expect(current_path).to eq('/signup')
			fill_in(:name, :with => "")
			click_button 'submit'
			expect(current_path).to eq('/signup')
			expect(page).to have_content("Please Sign Up Below")
		end
	end

	context "/users edit action" do
		it 'only authenticated users can edit a user' do
			visit '/users/edit'
			expect(current_path).to eq('/login')
		end

		it 'authenticated users can access /users/edit' do
			visit '/signup'
			user_signup
			visit '/users/edit'
			expect(current_path).to eq('/users/edit')
			expect(page).to have_content("Edit Your Profile Here:")
		end

		it 'only authenticated users can access /users/edit' do
			visit '/users/edit'
			expect(current_path).to eq('/login')
		end

		it 'submitting valid edit user form redirects to /profile' do
			visit '/signup'
			user_signup
			visit '/users/edit'
			fill_in(:name, :with => "wolfy")
			fill_in(:email, :with => "wilfred@wilfred.com")
			click_button 'submit'
			expect(current_path).to eq('/profile')
			expect(page).to have_content("wolfy")
		end

		it 'submitting invalid edit user form redirects to /users/edit' do
			visit '/signup'
			user_signup
			visit '/users/edit'
			fill_in(:name, :with => "")
			fill_in(:email, :with => "wilfred@wilfred.com")
			click_button 'submit'
			expect(current_path).to eq('/users/edit')
		end
		
	end

	context "/users delete action" do
		it 'delete action deletes an authenticated user' do
			visit '/signup'
			user_signup
			visit '/users/edit'
			click_button 'Delete User'
      expect(page.status_code).to eq(200)
			expect(User.count).to eq(0)
		end

		it 'delete action deletes the games and turns of an authenticated user' do
			visit '/signup'
			visit '/signup'
			user_signup
			Game.create(user_id: User.first.id, number_of_players: 4, name: "Catan")
			Turn.create(game_id: Game.first.id, result: 4)
			Turn.create(game_id: Game.first.id, result: 7)
			expect(User.count).to eq(1)
			expect(Game.count).to eq(1)
			expect(Turn.count).to eq(2)
			visit '/users/edit'
			click_button 'Delete User'
      expect(page.status_code).to eq(200)
			expect(User.count).to eq(0)
			expect(Game.count).to eq(0)
			expect(Turn.count).to eq(0)
		end

		it 'delete action redirects to root route for authenticated users' do
			visit '/signup'
			user_signup
			visit '/users/delete'
			fill_in(:name, :with => "")
			fill_in(:email, :with => "wilfred@wilfred.com")
			click_button 'submit'
			expect(current_path).to eq('/users/edit')
		end

		it 'delete action redirects to root route for authenticated users' do
			visit '/signup'
			user_signup
			visit '/users/delete'
			fill_in(:name, :with => "")
			fill_in(:email, :with => "wilfred@wilfred.com")
			click_button 'submit'
			expect(current_path).to eq('/users/edit')
		end
	end
end