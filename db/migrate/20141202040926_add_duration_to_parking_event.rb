class AddDurationToParkingEvent < ActiveRecord::Migration
  def change
    add_column :parking_events, :duration, :integer
  end
end
