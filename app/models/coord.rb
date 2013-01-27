class Coord < ActiveRecord::Base
  attr_accessible :lat, :lng, :ride_id

  belongs_to :ride
end
