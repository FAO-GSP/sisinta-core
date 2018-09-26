# Simple Map view object for MapController.

class Map
  include ActiveModel::Model

  attr_accessor :center, :zoom, :profiles_count, :public_profiles_count
end
