class UserRaceEventCreate < ActiveRecord::Migration
	
  def change
  	  create_table "user_race_events", :id => false, :force => true do |t|
	    t.string "race_id"
	    t.string "user_id"
	    t.string "uuid", primary: true
	    t.decimal "longitude"
	    t.decimal "latitude"
	    t.decimal "altitude"
	    t.decimal "horizontal_accuracy"
	    t.decimal "vertical_accuracy"
	    t.decimal "steps"
	    t.string "last_event_id"

	    t.timestamps
  	end
  end
end
