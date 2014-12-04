class Lot < ActiveRecord::Base
  has_many :parking_events

  geocoded_by :address
  after_validation :geocode


  def availability
    self.capacity - self.parking_events.where(time_out: nil).count
  end
end
