class UserRaceEventsController < ApplicationController
	def create

		user_race_event = UserRaceEvent.create( params.slice( 	:user_race_id,
																:longitude, 
																:latitude, 
																:altitude,
																:horizontal_accuracy,
																:vertical_accuracy,
																:steps,
																:last_event_id ))
		if user_race_event.invalid?
			render json: user_race_event.errors.messages, status: :bad_request
			return
		end

		respond_to do |format|
			format.json { render json: user_race_event.as_json( include: [ :race, :user, :last_event ] ) }
		end
	end
end