require 'spec_helper'

describe 'User Features' do

	def user_signup
		fill_in(:name, :with => "wilfred")
		fill_in(:email, :with => "wilfred@wilfred.com")
		fill_in(:password, :with => "wilfred")
		click_button 'submit'
	end
	
	context "Signup" do
	
		it 'signup form successful creates new user' do
			expect(User.all.length).to eq(0)
			visit '/signup'
			expect(current_path).to eq('/signup')
			user_signup
			expect(User.all.length).to eq(1)
			expect(User.first.name).to eq("wilfred")
		end
	end

	context "Edit" do
		
		it 'user edit form renders on /users/edit ' do
			visit '/signup'
			user_signup
			name_input = "<input type='text' name='name' value='#{User.first.name}'>"
			email_input = "<input type='text' name='email' value='#{User.first.email}'>"
			visit '/users/edit'
			expect(current_path).to eq('/users/edit')
			expect(find_field('name').value).to eq "#{User.first.name}"
			expect(find_field('email').value).to eq "#{User.first.email}"
		end

		it 'submitted edit user form updates user ' do
			visit '/signup'
			user_signup
			visit '/users/edit'
			fill_in(:name, :with => "wolfy")
			fill_in(:email, :with => "wilfred@wilfred.com")
			click_button 'submit'
			expect(current_path).to eq('/profile')
			expect(page).to have_content("wolfy")
			expect(User.first.name).to eq("wolfy")
		end
	end
end