class Lot < ActiveRecord::Base
  has_many :parking_events

  geocoded_by :address
  after_validation :geocode
end
