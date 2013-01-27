class Athlete < ActiveRecord::Base
  attr_accessible :strava_athlete_id, :location, :processed, :name

  has_many :rides
end
