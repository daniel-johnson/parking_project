class PaymentsController < ApplicationController
  def index
    @license = params[:license]
    @parking_events = ParkingEvent.where("license = ?", @license).where(stripe_txn_id: nil).where("time_out IS NOT ?", nil)
    @total = 0
    @parking_events.each do |parking_event|
      @total += parking_event.duration * parking_event.lot_rate
    end
    @total.round
  end

  def create
    @parking_events = ParkingEvent.where("license = ?", params[:license]).where(stripe_txn_id: nil).where("time_out IS NOT ?", nil)
    @confirm_total = 0

    @parking_events.each do |parking_event|
      @confirm_total += parking_event.duration * parking_event.lot_rate
    end
    if params[:total].to_i == @confirm_total.round
      Payment::ChargeWithStripe.new(token:          params[:stripe_card_token],
                                    total:          params[:total],
                                    license:        params[:license],
                                    parking_events: @parking_events).call
      #email receipt
      redirect_to root_path, notice: "Thank you, your payment has been received. An receipt has been emailed to you."
    else
      redirect_to root_path, alert: "Error, could not process request, please try again."
    end
  end
end
