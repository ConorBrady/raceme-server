class CreateUserRaceLinkTable < ActiveRecord::Migration

  	def change
  		create_table "user_races", :id => false, :force => true do |t|
  			t.string "race_id"
  			t.string "user_id"
  			t.string "uuid"

  			t.timestamps
  		end
  	end
  	
  	remove_column :user_race_events, :race_id
  	remove_column :user_race_events, :user_id
  	add_column :user_race_events, :user_race_id, :string

end
