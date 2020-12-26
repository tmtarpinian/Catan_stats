require_relative '../support/login_helper'
require 'spec_helper'

describe 'Feature Test: User Signup', :type => :feature do
    it 'successfully signs up a user' do
        visit '/signup'
        expect(current_path).to eq('/signup')
        # user_signup method is defined in login_helper.rb
        user_signup
        expect(current_path).to eq('/profile')
        expect(page).to have_content(@username)
      end

end
# describe "Users Routes" do
# 	let(:user) {User.create(name: "Dirty Harry", email: "email@email.com", password: "password")}
#   let(:game_name) { "Catan" }
# 	let(:game_players_3) { 3 }

#   before do
# 		@game = Game.create(:name => game_name, :number_of_players => game_players_3, :user_id => user.id)
# 		@turn = Turn.create(:result => 5, :game_id => @game.id)
#   end

# 	describe "Edit page '/games/:id/turns/:id/edit'" do

# 		before do
# 			visit "/games/:id/turns/:id/edit"
# 		end
#     end