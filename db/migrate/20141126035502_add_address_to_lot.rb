class AddAddressToLot < ActiveRecord::Migration
  def change
    add_column :lots, :address, :string
  end
end
