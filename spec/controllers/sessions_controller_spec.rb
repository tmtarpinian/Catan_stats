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

    context "/logout controller action" do
        it 'successfully logs out a logged-in user' do
            User.create(:name => "wilfred", :email => "wilfred@wilfred.com", :password => "wilfred")        
            visit '/login'
            fill_in(:email, :with => "wilfred@wilfred.com")
            fill_in(:password, :with => "wilfred")
            click_button 'submit'
            visit '/profile'
            
            expect(session[:id]).to eq(1)
            expect(current_path).to eq('/profile')
            expect(page).to have_content("wilfred")
            visit '/logout'
            expect(current_path).to eq('/')
        end

        it 'redirects the homepage after logout' do
            User.create(:name => "wilfred", :email => "wilfred@wilfred.com", :password => "wilfred")
            visit '/login'
            fill_in(:email, :with => "wilfred@wilfred.com")
            fill_in(:password, :with => "wilfred")
            click_button 'submit'
            visit '/profile'
            expect(current_path).to eq('/profile')
            expect(page).to have_content("wilfred")
            visit '/logout'
            expect(current_path).to eq('/')
        end

        it 'redirects anyone other than a logged-in user to the homepage' do
            visit '/logout'
            expect(current_path).to eq('/')
        end

        it 'access to site requires authentication after /logout' do
            visit '/logout'
            expect(current_path).to eq('/')
            visit '/profile'
            expect(current_path).to eq('/login')
        end
    end
end


get '/logout' do
    if logged_in?
        session.clear
        redirect '/'
    else
        redirect '/'
    end
end