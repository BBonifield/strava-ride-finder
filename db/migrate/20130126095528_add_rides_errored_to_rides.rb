class AddRidesErroredToRides < ActiveRecord::Migration
  def change
    add_column :rides, :rides_errored, :boolean, :default => false
  end
end
