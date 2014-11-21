class CreateLots < ActiveRecord::Migration
  def change
    create_table :lots do |t|
      t.integer :capacity
      t.integer :rate

      t.timestamps
    end
  end
end
