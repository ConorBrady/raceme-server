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
      format.json { render json: @races.as_json(
                                                only: [ :distance, :start_time, :uuid ],
                                                include: 
                                                { 
                                                    user: 
                                                    { 
                                                        only: [ :name , :uuid ] 
                                                    } 
                                                } ) } 
     
    end  			
  end

  def show
    @race = Race.find(params[:id])
    respond_to do |format|
      format.json { render json: @race.as_json(
                                              only: [ :distance, :start_time, :uuid ],
                                              include: 
                                              { 
                                                  user: 
                                                  { 
                                                      only: [ :name , :uuid ] 
                                                  }, 
                                                  leaderboard: 
                                                  { 
                                                      only: [ :created_at, :distance_run, :address ], 
                                                      include: 
                                                      { 
                                                          user: 
                                                          { 
                                                            only: [ :name, :uuid ] 
                                                          } 
                                                      } 
                                                  } 
                                              } ) }
    end   
  end

  def create

    @race = @current_user.races.create( params.slice(:start_time, :distance) )

    if @race.invalid?
      render json: @race.errors.messages, status: :bad_request
      return
    end

    respond_to do |format|
      format.json { render json: @race.as_json(
                                                only: [ :distance, :start_time, :uuid ],
                                                include: 
                                                { 
                                                    user: 
                                                    { 
                                                        only: [ :name , :uuid ] 
                                                    } 
                                                } ) } 
    end
  end
end
