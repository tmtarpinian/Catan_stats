require 'spec_helper'

describe 'User Controller', type: :feature do
	context "/signup action" do
		def user_signup
			fill_in(:name, :with => "wilfred")
			fill_in(:email, :with => "wilfred@wilfred.com")
			fill_in(:password, :with => "wilfred")
			click_button 'submit'
		end

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
			user_signup
			expect(current_path).to eq('/profile')
			expect(page).to have_content("wilfred")
		end
	do
end