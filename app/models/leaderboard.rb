class Leaderboard < ActiveRecord::Base
	
	belongs_to :user_race_event

	has_one :race, through: :user_race_event
	has_one :user, through: :user_race_event

	attr_accessible :user_race_event, :distance_run

	validates :distance_run,
  				  numericality: { greater_than_or_equal: 0 },
  				  presence: true

  	validates_presence_of :user_race_event
end