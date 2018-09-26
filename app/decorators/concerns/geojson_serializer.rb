# Helper methods for GeoJSON serialization, included by decorators.
module GeojsonSerializer
  # Primary generator method, called by ProfilesController each request.
  def as_json(*_args)
    RGeo::GeoJSON.encode factory.feature_collection(features)
  end

  # Accessor for the default RGeo::GeoJSON feature/s factory.
  def factory
    RGeo::GeoJSON::EntityFactory.instance
  end
end
