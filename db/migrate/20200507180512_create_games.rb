class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
        t.string :name
        t.datetime :date
        t.boolean :complete, default: false
        t.integer :user_id
    end
end
end
