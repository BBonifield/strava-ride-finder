class Ride < ActiveRecord::Base
  attr_accessible :athlete_id, :strava_ride_id, :name, :average_lat, :average_lng, :latlng, :averaged

  belongs_to :athlete
  has_many :coords
end
