class AthleteLoader
  MAX_ATHLETE_COUNT = 10000

  def self.load
    self.new.start
  end

  def start
    while retrieve_more_athletes && (athlete = next_athlete)
      puts "Loading follows for: #{athlete.name}"

      load_follows athlete, :following
      load_follows athlete, :followers

      athlete.update_attribute :friends_processed, true
    end
  end


  private


  def retrieve_more_athletes
    @load_count ||= 0
    @load_count += 1
    # only check the actual count every 50 records
    if @load_count % 50 == 0
      Athlete.count < MAX_ATHLETE_COUNT
    else
      true
    end
  end

  def load_follows athlete, type, page=1
    follows_page = mech.get "http://app.strava.com/athletes/#{athlete.strava_athlete_id}/follows?type=#{type}&page=#{page}"
    follows_page.search('.following.athletes li').each do |follower|
      desc = follower.css('.description')
      strava_athlete_id = desc.css('a').attr('href').value.gsub(/^.*\/(\d+)$/, "\\1")
      name, location = desc.text.strip.split("\n")

      create_athlete strava_athlete_id, name, location
    end

    load_follows(athlete, type, page+1) if follows_page.search('a.next_page').any?
  end

  def create_athlete strava_athlete_id, name, location
    if desired_location? location
      Athlete.where(:strava_athlete_id => strava_athlete_id).first_or_create! :name => name,
        :location => location
    end
  end

  def desired_location? location
    cities = [ "Boulder", "Broomfield", "Longmont", "Lafeyette", "Lyons", "Nederland", "Gunbarrel", "Niwot", "Superior" ]
    cities.any? do |city|
      city_matcher = Regexp.new "#{city}, co", true
      location =~ city_matcher
    end
  end


  def mech
    return @mech if @mech

    @mech = Mechanize.new
    # login
    login_page = mech.get 'https://www.strava.com/login'
    login_page.form_with(:action => '/session') do |f|
      f.email = ENV['STRAVA_EMAIL']
      f.password = ENV['STRAVA_PASSWORD']
    end.submit

    @mech
  end


  def next_athlete
    Athlete.where(:friends_processed => false).first
  end
end
