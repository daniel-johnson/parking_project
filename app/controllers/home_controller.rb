class HomeController < ApplicationController
  def index
    @lots = Lot.all
    @hash = Gmaps4rails.build_markers(@lots) do |lot, marker|
      marker.lat lot.latitude
      marker.lng lot.longitude
      marker.infowindow "<p>Lot Address: #{lot.address}</p> <p>Available Stalls: #{lot.availability}</p> <p>Parking Rate: $#{((lot.rate*60*60).round)/100}/hour</p>"
    end
  end
end
