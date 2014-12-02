class AddCustomerIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :customer_id, :string, index: true
  end
end
