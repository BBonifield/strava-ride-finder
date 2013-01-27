class CreateCoords < ActiveRecord::Migration
  def change
    create_table :coords do |t|
      t.integer :ride_id
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
