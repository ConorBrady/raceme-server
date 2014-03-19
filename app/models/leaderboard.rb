class Leaderboard < ActiveRecord::Base
	
	self.primary_key = :user_race_event_id

	belongs_to :user_race_event

	has_one :user_race, through: :user_race_event

	has_one :race, through: :user_race
	has_one :user, through: :user_race
	
	attr_accessible :user_race_event, :distance_run

	validates :distance_run,
  				  numericality: { greater_than_or_equal: 0 },
  				  presence: true

  	validates_presence_of :user_race_event

  	def address
  		self.user_race_event.address
  	end
end