class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.integer :result 
      t.integer :game_id
    end
  end
end
