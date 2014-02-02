class UsersController < ApplicationController
	
	skip_before_filter :authenticate, only: [:create]

	def index
		respond_to do |format|
			format.json { render json: @current_user }
		end
	end

	def create

		full_name = params[:name]
		email = params[:email]
		password = params[:password]
		confirm_password = params[:confirm_password]

		unless /^(?i)([À-ÿa-z\-\s]{2,})+$/ =~ full_name
			render status: :bad_request, json: { message: "Invalid full_name provided"}
			return
		end

		unless /^[0-9a-zA-Z]+([0-9a-zA-Z]*[-._+])*[0-9a-zA-Z]+@[0-9a-zA-Z]+([-.][0-9a-zA-Z]+)*([0-9a-zA-Z]*[.])[a-zA-Z]{2,6}$/ =~ email
			render status: :bad_request, json: { message: "Invalid email provided" }
			return
		end

		unless /^([a-zA-Z0-9@*#]{8,15})$/ =~ password
			render status: :bad_request, json: { message: "Invalid password provided" }
			return
		end

		unless password == confirm_password
			render status: :bad_request, json: { message: "passwords do not match" }
			return
		end

		unless User.where(email:email).count == 0
			render status: :conflict, json: { message: "email already exists" }
			return
		end

		@user = User.create(name: full_name, 
							email: email, 
							password: password, 
							password_confirmation: confirm_password)
		
		respond_to do |format|
			format.json { render json: @user }
		end
	end
end
