class AddIndexesToLot < ActiveRecord::Migration
  def change
    add_index :lots, :capacity
    add_index :lots, :rate
    add_index :lots, :address
    add_index :lots, :latitude
    add_index :lots, :longitude
  end
end
