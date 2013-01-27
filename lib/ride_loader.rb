class RideLoader
  RPP = 50

  def self.load
    self.new.start
  end

  def start
    while athlete = next_athlete
      begin
        puts "Loading rides for: #{athlete.name}"

        load_rides athlete

        athlete.update_attribute :rides_processed, true
      rescue Exception => e
        athlete.rides_processed = true
        athlete.rides_errored = true
        athlete.save!
      end
    end
  end


  private


  def load_rides athlete, offset=0
    rides = strava.rides :athlete_id => athlete.strava_athlete_id,
      :offset => offset

    rides.each do |ride|
      stream = strava.ride_streams ride.id
      athlete.rides.create :strava_ride_id => ride.id,
        :name => ride.name,
        :latlng => Marshal.dump(stream.latlng)
    end

    load_rides(athlete, offset+RPP) if rides.length == RPP
  end

  def strava
    @strava ||= StravaApi::Base.new
  end

  def next_athlete
    Athlete.where(:rides_processed => false).first
  end
end
