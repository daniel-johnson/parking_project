class ParkingEventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    populate_new_event

    @parking_event = ParkingEvent::SearchForExistingEvent.new( new_event: @new_event )
  end

  def new
    @parking_event = ParkingEvent.new
  end

  private

  def populate_new_event
    @new_event = ParkingEvent.new parking_event_params
    @new_event.time_in ||= Time.now
    @new_event.lot_id ||= 1
    @new_event.license = parse_license(parking_event_params[:photo_in].tempfile.path)
  end

  def parking_event_params
    params.require(:parking_event).permit(:lot_id, :photo_in, :time_in)
  end

  def parse_license(license_path)
    e = Tesseract::Engine.new {|e|
      e.language  = :eng
      e.blacklist = '|'
    }
    e.text_for(license_path).strip
  end

end