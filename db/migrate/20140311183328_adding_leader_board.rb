class AddingLeaderBoard < ActiveRecord::Migration
  	def change
  		create_table "leaderboards", :id => false, :force => true do |t|
  			t.string "user_race_event_id"
  			t.decimal "distance_run"
  			t.timestamps
  		end
  	end
end
