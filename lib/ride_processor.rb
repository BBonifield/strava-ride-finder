class RideProcessor
  MIN_LAT = 39.799041
  MAX_LAT = 40.727486
  MIN_LNG = -105.721436
  MAX_LNG = -104.915314

  def self.process
    self.new.start
  end

  def start
    while ride = next_ride
      puts "Averaging ride: #{ride.id} -- #{ride.name}"

      lat_sum = 0
      lng_sum = 0

      latlng = Marshal.load ride.latlng
      unless latlng.nil?
        latlng.each do |coords|
          lat, lng = coords

          unless lat.nil? || lng.nil?
            lat_sum += lat
            lng_sum += lng

            # skip coords that are not in the boulder area
            if coords_in_bounds? lat, lng
              ride.coords.create :lat => lat.round(4),
                :lng => lng.round(4)
            end
          end
        end

        ride.average_lat = (lat_sum / latlng.length).round(6)
        ride.average_lng = (lng_sum / latlng.length).round(6)
      end

      ride.averaged = true
      ride.save!
    end
  end


  private


  def coords_in_bounds? lat, lng
    (lat >= MIN_LAT) &&
      (lat <= MAX_LAT) &&
      (lng >= MIN_LNG) &&
      (lng <= MAX_LNG)
  end

  def next_ride
    Ride.where(:averaged => false).order('id').first
  end
end
