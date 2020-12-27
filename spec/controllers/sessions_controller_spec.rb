require 'spec_helper'

describe 'Sessions Controller', type: :feature do
    context "/login controller action" do
        it "renders login page successfully" do
            visit '/login'
            expect(page.status_code).to eq(200)
        end

        it 'successful login redirects to user profile page' do
            User.create(:name => "wilfred", :email => "wilfred@wilfred.com", :password => "wilfred")
            visit '/login'
            fill_in(:email, :with => "wilfred@wilfred.com")
            fill_in(:password, :with => "wilfred")
            click_button 'submit'
            visit '/profile'
            expect(current_path).to eq('/profile')
            expect(page).to have_content("wilfred")
        end

        it 'redirects unsuccessful logins back to login page' do
            visit '/login'
            fill_in(:email, :with => "")
            fill_in(:password, :with => "")
            click_button 'submit'
            expect(current_path).to eq('/login')
        end
    end
end
