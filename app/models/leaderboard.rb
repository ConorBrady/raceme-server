class Leaderboard < ActiveRecord::Base
	
	belongs_to :user_race_event

	has_one :race, through: user_race_event
	has_one :user, through: user_race_event

	attr_accessible :last_event_id, :distance_run

	validates :distance_run,
  				  numericality: {greater_than: 0},
  				  presence: true
end