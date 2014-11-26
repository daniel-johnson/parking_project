class ParkingEvent < ActiveRecord::Base
  mount_uploader :photo_in, PhotoInUploader
  mount_uploader :photo_out, PhotoOutUploader
  belongs_to :lot

end
