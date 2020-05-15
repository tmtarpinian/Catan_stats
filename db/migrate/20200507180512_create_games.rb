class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
        t.string :name
        t.datetime :gamedate, default: Time.now
        t.string :status, default: "In Progress"
        t.integer :user_id
    end
end
end


