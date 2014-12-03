class ParkingEvent < ActiveRecord::Base
  mount_uploader :photo_in, PhotoInUploader
  mount_uploader :photo_out, PhotoOutUploader
  belongs_to :lot
  belongs_to :user

  delegate :rate, to: :lot, prefix: true
  delegate :address, to: :lot
  delegate :customer_id, to: :user

  def populate_duration
    self.duration = self.time_out - self.time_in
  end

end
