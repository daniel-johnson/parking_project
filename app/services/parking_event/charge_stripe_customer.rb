class ParkingEvent::ChargeStripeCustomer

  include Virtus.model

  attribute :parking_event, ParkingEvent

  def call
    begin
      charge = Stripe::Charge.create(
               amount:      amount,
               currency:    "cad",
               customer:    parking_event.customer_id,
               description: description)
      parking_event.stripe_txn_id = charge.id
      parking_event.save
    rescue => e
      parking_event.error_message = e.message
      parking_event.save
    end
  end

  private

  def amount
    (parking_event.lot_rate * parking_event.duration).round
  end

  def description
    "License: #{parking_event.license} | Lot: #{parking_event.address} | Time in: #{parking_event.time_in} | Time out: #{parking_event.time_out}"
  end
end
