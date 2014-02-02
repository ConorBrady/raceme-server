class Race < ActiveRecord::Base

	self.primary_key = :uuid

	before_create { self.uuid = SecureRandom.uuid }
	
	belongs_to :user

  	attr_accessible :distance, :start_time

end
