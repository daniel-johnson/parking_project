class HomeController < ApplicationController
  def index
    @lots = Lot.all

    @hash = Gmaps4rails.build_markers(@lots) do |lot, marker|
      marker.lat lot.latitude
      marker.lng lot.longitude
      marker.title lot.address
    end
  end
end
