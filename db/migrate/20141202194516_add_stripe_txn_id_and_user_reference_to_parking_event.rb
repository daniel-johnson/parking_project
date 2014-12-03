class AddStripeTxnIdAndUserReferenceToParkingEvent < ActiveRecord::Migration
  def change
    add_column :parking_events, :stripe_txn_id, :string, index: true
    add_reference :parking_events, :user, index: true
  end
end
