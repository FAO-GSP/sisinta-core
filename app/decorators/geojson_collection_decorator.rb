# A collection of Profiles decorated with GeojsonDecorator for geojson
# serialization.
class GeojsonCollectionDecorator < Draper::CollectionDecorator
  include GeojsonSerializer

  # Use this class for item decoration.
  def decorator_class
    GeojsonDecorator
  end

  # Wraps every Profile as a RGeo::GeoJSON feature. Called by `as_json` from
  # ProfilesController.
  def features
    decorated_collection.map(&:as_feature)
  end
end
