namespace :strava do
  desc 'Load all athletes'
  task :load_athletes => :environment do
    AthleteLoader.load
  end
  desc 'Load all rides'
  task :load_rides => :environment do
    RideLoader.load
  end
  task :process_rides => :environment do
    RideProcessor.process
  end

end
