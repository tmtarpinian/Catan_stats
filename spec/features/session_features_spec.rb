require 'spec_helper'

describe 'Session Features', type: :feature do
	context "Signin" do

        it 'signin successfully logs in new user' do
            User.create(:name => "wilfred", :email => "wilfred@wilfred.com", :password => "wilfred")
            visit '/login'
            fill_in(:email, :with => "wilfred@wilfred.com")
			fill_in(:password, :with => "wilfred")
			click_button 'submit'
            visit '/profile'
            expect(current_path).to eq('/profile')
			expect(page).to have_content("wilfred")
		end
	end
end