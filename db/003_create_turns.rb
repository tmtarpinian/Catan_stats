class CreateTurns < ActiveRecord::Migration
    def change
        create_table :turns do |t|
        t.integer :role_result  #this will be a number 2-12
        t.integer :game_id
        t.integer :user_id
    end
end