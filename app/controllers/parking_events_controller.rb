class ParkingEventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    @new_event = ParkingEvent.new parking_event_params
    @new_event.license = parse_license(parking_event_params[:photo_in].tempfile.path)
    @existing_event = unresolved_parking_events(@new_event).first

    if @existing_event.nil?
      @new_event.save
      redirect_to new_parking_event_path, notice: "New Parking Event Created"
    else
      @existing_event.time_out = @new_event.time_in
      @existing_event.photo_out = @new_event.photo_in
      @existing_event.populate_duration
      
      @user = User.where(license: @existing_event.license).first
      if @user
        @existing_event.user = @user
        ParkingEvent::PreauthorizedCharge.new(parking_event: @existing_event).call
      end
      @existing_event.save
      redirect_to new_parking_event_path, notice: "Existing Parking Event Populated"
    end
  end

  def new
    @parking_event = ParkingEvent.new
  end

  private

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

  def unresolved_parking_events(parking_event)
    ParkingEvent.where(photo_out: nil).where(["lot_id = ? and license = ?", @new_event.lot_id, @new_event.license])
    # ParkingEvent.where(["lot_id = ? and photo_out = ? and license = ?", "#{parking_event.lot_id}", nil, "#{parking_event.license}"])
  end
end