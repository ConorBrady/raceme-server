class UserRacesController < ApplicationController
	def create
		user_race = @current_user.user_races.create(params.slice(:race_id))
		if user_race.invalid?
			render json: user_race.errors.messages, status: :bad_request
			return
		end

		respond_to do |format|
			format.json { render json: user_race }
		end
	end
end