class AddErrorMessageToParkingEvent < ActiveRecord::Migration
  def change
    add_column :parking_events, :error_message, :string
  end
end
