require 'spec_helper'

describe 'User Features' do
	context "Signup" do
		def user_signup
			fill_in(:name, :with => "wilfred") #requried string
			fill_in(:email, :with => "wilfred@wilfred.com")
			fill_in(:password, :with => "wilfred")
			click_button 'submit'
		end

		def user_signin
			fill_in(:email, :with => @email)
			fill_in(:password, :with => @password)
			click_button 'submit'
		end

		it 'signup successful creates new user' do
			expect(User.all.length).to eq(0)
			visit '/signup'
			expect(current_path).to eq('/signup')
			user_signup
			expect(User.all.length).to eq(1)
			expect(User.first.name).to eq("wilfred")
		end

		it 'successful signup redirects to profile' do
			visit '/signup'
			expect(current_path).to eq('/signup')
			user_signup
			expect(current_path).to eq('/profile')
			expect(page).to have_content("wilfred")
		end
	end
end