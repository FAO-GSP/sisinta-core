# Shows maps.

class MapController < ApplicationController
  # Prepares the landing page with a profile map.
  def index
    @map = Map.new(
      center: Rails.configuration.engine.map_center,
      zoom: Rails.configuration.engine.map_zoom,
      profiles_count: Profile.count,
      public_profiles_count: Profile.public_ones.count
    )
  end
end
