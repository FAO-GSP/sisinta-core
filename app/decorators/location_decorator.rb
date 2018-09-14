# Location presentation methods
class LocationDecorator < ApplicationDecorator
  def coordinates
    [object.latitude, object.longitude].join ', '
  end
end
