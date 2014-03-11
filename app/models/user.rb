class User < ActiveRecord::Base

	self.primary_key = :uuid
	
	has_many :races, dependent: :delete_all
	has_many :user_races, dependent: :delete_all

	VALID_EMAIL_REGEX = /^[0-9a-zA-Z]+([0-9a-zA-Z]*[-._+])*[0-9a-zA-Z]+@[0-9a-zA-Z]+([-.][0-9a-zA-Z]+)*([0-9a-zA-Z]*[.])[a-zA-Z]{2,6}$/
	VALID_NAME_REGEX = /^(?i)([A-Za-z\-\s]{2,})+$/
	VALID_PASSWORD_REGEX = /^([a-zA-Z0-9@*#]{8,15})$/

	attr_accessible :name, :password, :email, :password_confirmation

	before_create { self.uuid = SecureRandom.uuid }

  before_save   { self.email = email.downcase }

	validates :name, 
				presence: 		true, 
				format: 		{ with: VALID_NAME_REGEX }
	
	validates :email, 		
				    presence:   	true,
            format:     	{ with: VALID_EMAIL_REGEX },
            uniqueness: 	{ case_sensitive: false }
	
	validates :password, 	
				    presence: 		true,
				    format: 		{ with: VALID_PASSWORD_REGEX },
				    confirmation: 	true

	validates :password_confirmation,
				    presence: 		true

	has_secure_password
end
