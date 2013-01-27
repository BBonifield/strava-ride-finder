class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :strava_ride_id
      t.integer :athlete_id
      t.string :name
      t.text :latlng
      t.float :average_lat
      t.float :average_lng
      t.boolean :averaged, :default => false

      t.timestamps
    end
  end
end
