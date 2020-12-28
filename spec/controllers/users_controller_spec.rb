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

		it 'submitting edit user form redirects to /profile' do
			visit '/signup'
			user_signup
			visit '/users/edit'
			fill_in(:name, :with => "wolfy")
			fill_in(:email, :with => "wilfred@wilfred.com")
			click_button 'submit'
			expect(current_path).to eq('/profile')
			expect(page).to have_content("wolfy")
		end
		
	end

	context "/users delete action" do
	end
end