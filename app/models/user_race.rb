class UserRace < ActiveRecord::Base

	self.primary_key = :uuid

	belongs_to :user
	belongs_to :race

	has_many :user_race_events

	validates_presence_of :user
	validates_presence_of :race

	before_create { self.uuid = SecureRandom.uuid }

	attr_accessible :race_id
end