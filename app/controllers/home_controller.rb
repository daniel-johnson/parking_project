class HomeController < ApplicationController
  def index
    @lot = Lot.first
  end
end
