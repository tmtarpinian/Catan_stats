require 'spec_helper'

describe 'User Features' do
	context "Signup" do
		def user_signup
			fill_in(:name, :with => "wilfred")
			fill_in(:email, :with => "wilfred@wilfred.com")
			fill_in(:password, :with => "wilfred")
			click_button 'submit'
		end

		it 'signup form successful creates new user' do
			expect(User.all.length).to eq(0)
			visit '/signup'
			expect(current_path).to eq('/signup')
			user_signup
			expect(User.all.length).to eq(1)
			expect(User.first.name).to eq("wilfred")
		end
	end
end