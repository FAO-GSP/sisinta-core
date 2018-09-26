# Location presentation methods
class LocationDecorator < ApplicationDecorator
  def coordinates
    coordinates_array.join ', ' if coordinates_array.present?
  end

  def coordinates_array
    if object.latitude.present? && object.longitude.present?
      [object.latitude, object.longitude]
    end
  end
end
