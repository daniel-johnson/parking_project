class ChangeRateValueForLots < ActiveRecord::Migration
  def change
    remove_column :lots, :rate, :integer
    add_column :lots, :rate, :float
  end
end
