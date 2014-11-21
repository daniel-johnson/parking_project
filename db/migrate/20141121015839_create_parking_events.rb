class CreateParkingEvents < ActiveRecord::Migration
  def change
    create_table :parking_events do |t|
      t.datetime :time_in
      t.datetime :time_out
      t.string :license
      t.string :photo_in
      t.string :photo_out
      t.integer :lot_id

      t.timestamps
    end
  end
end
