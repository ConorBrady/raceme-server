class Race < ActiveRecord::Base

	self.primary_key = :uuid

	before_create { self.uuid = SecureRandom.uuid }
	
	belongs_to :user

	has_many :user_race, dependent: :delete_all

  has_many :leaderboard, through: :user_race

  attr_accessible :distance, :start_time

  validates :distance,
  				  numericality: {greater_than: 0},
  				  presence: true

  validate :validate_start_time

  def validate_start_time
  	if self.start_time.nil?
  		errors.add(:start_time, "invalid start_time")
  	elsif start_time <= Time.now
  		errors.add(:start_time, "start_time must be after current time")
  	end
  end
end
