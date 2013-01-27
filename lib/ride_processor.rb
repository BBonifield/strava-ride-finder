class RideProcessor

  def self.process
    self.new.start
  end

  def start
    while ride = next_ride
      puts "Averaging ride: #{ride.name}"

      lat_sum = 0
      lng_sum = 0
      latlng = Marshal.load ride.latlng
      latlng.each do |coords|
        lat_sum += coords[0]
        lng_sum += coords[1]
        ride.coords.create :lat => coords[0].round(4),
          :lng => coords[1].round(4)
      end

      ride.average_lat = (lat_sum / latlng.length).round(6)
      ride.average_lng = (lng_sum / latlng.length).round(6)
      ride.averaged = true
      ride.save!
    end
  end


  private


  def next_ride
    Ride.where(:averaged => false).first
  end
end
