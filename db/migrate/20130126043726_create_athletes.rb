class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.integer :strava_athlete_id
      t.string :name
      t.string :location
      t.boolean :friends_processed, :default => false
      t.boolean :rides_processed, :default => false

      t.timestamps
    end
  end
end
