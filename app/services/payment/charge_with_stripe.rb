class Payment::ChargeWithStripe

  include Virtus.model

  attribute :token,           String
  attribute :total,           Integer
  attribute :license,         String
  attribute :parking_events,  Array[ParkingEvent]

  def call
    begin
      charge = Stripe::Charge.create(
               amount:      total,
               currency:    "cad",
               card:        token,
               description: description)
      parking_events.each do |parking_event|
        parking_event.stripe_txn_id = charge.id
        parking_event.save
      end
    rescue => e
      parking_event.error_message = e.message
      parking_event.save
    end
  end

  private

  def description
    "Parking for license plate #{license}. Please sign up for an account at our website for access to parking history and details."
  end 
end
