module ParkingEventsHelper

  def parse_license(picture_path)
    e = Tesseract::Engine.new {|e|
    e.language  = :eng
    e.blacklist = '|'
    }
    e.text_for(picture_path).strip
  end
end
