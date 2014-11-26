class AddLatitudeAndLongitudeToLot < ActiveRecord::Migration
  def change
    add_column :lots, :latitude, :float
    add_column :lots, :longitude, :float
  end
end
