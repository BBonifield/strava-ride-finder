class AddRidesErroredToAthletes < ActiveRecord::Migration
  def change
    add_column :athletes, :rides_errored, :boolean, :default => false
  end
end
