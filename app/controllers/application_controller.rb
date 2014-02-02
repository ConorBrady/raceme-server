class ApplicationController < ActionController::Base
  	
  	protect_from_forgery
  	
  	before_filter :authenticate

  	private 

  	def authenticate
  		authenticate_or_request_with_http_basic do |email, password|
  			user = User.where(email:email)[0]
  			if user
  				@current_user = user.authenticate(password)
  			end
  		end
  	end
end
