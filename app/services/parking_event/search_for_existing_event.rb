class ParkingEvent::SearchForExistingEvent

  include Virtus.model

  attribute :new_event, ParkingEvent

  def call
    existing_event = unresolved_parking_events(new_event).first

    if existing_event.nil?
      new_event.save
      new_event
    else
      existing_event.time_out = new_event.time_in
      existing_event.photo_out = new_event.photo_in
      existing_event.populate_duration
      
      user = User.where(license: existing_event.license).first
      if user
        existing_event.user = user
        ParkingEvent::ChargeStripeCustomer.new(parking_event: existing_event).call
      end
      existing_event.save
      redirect_to new_parking_event_path, notice: "Existing Parking Event Populated"
      existing_event
    end
  end

  private

  def unresolved_parking_events(parking_event)
    ParkingEvent.where(photo_out: nil).where(["lot_id = ? and license = ?", new_event.lot_id, new_event.license])
    # ParkingEvent.where(["lot_id = ? and photo_out = ? and license = ?", "#{parking_event.lot_id}", nil, "#{parking_event.license}"])
  end
  
  
end
