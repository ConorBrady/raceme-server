class UsersController < ApplicationController
	
	skip_before_filter :authenticate, only: [:create]

	def index
		respond_to do |format|
			format.json { render json: @current_user.as_json( except: :password_digest ) }
		end
	end

	def create		

		@user = User.create(name: params[:name],
							email: params[:email],
							password: params[:password],
							password_confirmation: params[:password_confirmation])
		if @user.invalid?

			if @user.errors.keys.include? :email and @user.errors[:email].include? "has already been taken"
				render json: @user.errors.messages, status: :conflict
				return
			else
				render json: @user.errors.messages, status: :bad_request
				return
			end
		end

		respond_to do |format|
			format.json { render json: @user }
		end
	end
end
