class UserRaceEvent < ActiveRecord::Base

	self.primary_key = :uuid

	belongs_to :user_race

	has_one :race, through: :user_race
	has_one :user, through: :user_race

	before_create { self.uuid = SecureRandom.uuid }

	belongs_to :last_event, class_name: "UserRaceEvent", foreign_key: :last_event_id
	
	attr_accessible :user_race_id, :longitude, :latitude,
				    :altitude, :horizontal_accuracy,
				    :vertical_accuracy, :steps, :last_event_id

	validates_presence_of :user_race

	validates :last_event, 
				presence: true, 
				:if => :last_event_id?

	validates :longitude, 
				numericality: { 
					greater_than_or_equal_to: -180, 
					less_than_or_equal_to: 180
				}, 
				presence: true

	validates :latitude, 
				numericality: { 
					greater_than_or_equal_to: -90, 
					less_than_or_equal_to: 90
				}, 
				presence: true

	validates :altitude, 
				numericality: true, 
				presence: true

	validates :horizontal_accuracy,
				numericality: {
					greater_than_or_equal_to: 0
				},
				presence: true

	validates :vertical_accuracy,
				numericality: {
					greater_than_or_equal_to: 0
				},
				presence: true

	validates :steps,
				numericality: {
					only_integer: true,
					greater_than_or_equal_to: 0
				},
				presence: true

end