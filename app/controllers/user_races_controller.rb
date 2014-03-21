class UserRacesController < ApplicationController

	def show
		user_race = UserRace.find(params[:id])

		respond_to do |format|
			format.json do
				render json: user_race.as_json( only: [ :uuid ] )
			end
		end
	end

	def create
		user_race = @current_user.user_races.create(params.slice(:race_id))
		if user_race.invalid?
			render json: user_race.errors.messages, status: :bad_request
			return
		end

		respond_to do |format|
			format.json do
			 	render json: user_race.as_json( only: [ :uuid ] ) 
			end
		end
	end
end