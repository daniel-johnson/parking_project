class AddCcFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_4, :integer
    add_column :users, :exp_month, :integer
    add_column :users, :exp_year, :integer
  end
end
