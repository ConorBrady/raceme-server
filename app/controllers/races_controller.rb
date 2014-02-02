class RacesController < ApplicationController
  	
  	def index

  		if params.keys.include? "limit"
  			limit = params[:limit].to_i
  		else
  			limit = 10
  		end

  		if params.keys.include? "starting_after"
  			starting_after = DateTime.iso8601(params[:starting_after])
  		else
  			starting_after = Time.now
  		end
  		
  		@races = Race.where("start_time > ?",starting_after).limit(limit)

		respond_to do |format|
			format.json { render json: @races.as_json(include: { user: { only: [ :name , :uuid ] } }, 
													   except: [ :user_id, :updated_at, :created_at ] ) }
		end  			

	end

	def show
	  	@race = Race.find(params[:id])
  		respond_to do |format|
  			format.json { render json: @race.as_json(include: { user: { only: [ :name , :uuid ] } }, 
													  except: [ :user_id, :updated_at, :created_at ] ) }
  		end
  	end

  	def create

  		unless params.keys.include? "start_time"
  			render status: :bad_request, json: { message: "start time must be provided"}
  			return
  		end

  		unless params.keys.include? "distance"
  			render status: :bad_request, json: { message: "distance must be provided"}
  			return
  		end

  		begin 
  			start_time = DateTime.iso8601(params[:start_time])
  			distance = params[:distance].to_f
  		rescue 
  			render status: :bad_request, json: { message: "parameter parse error" }
  			return
  		end

  		unless start_time > Time.now
  			render status: :bad_request, json: { message: "race start time is before current time"}
  			return
  		end

  		unless distance > 0
  			render status: :bad_request, json: { message: "distance must be a positive number" }
  			return
  		end

  		@race = @current_user.races.create( start_time: start_time, distance: distance )

  		respond_to do |format|
  			format.json { render json: @race.as_json(include: { user: { only: [ :name , :uuid ] } }, 
													  except: [ :user_id, :updated_at, :created_at ] ) }
  		end
  	end
end
