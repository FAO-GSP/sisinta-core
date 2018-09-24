# A collection of Profiles decorated with GeojsonDecorator for geojson
# serialization
class GeojsonCollectionDecorator < Draper::CollectionDecorator
  # Use this class for item decoration
  def decorator_class
    GeojsonDecorator
  end

  # Primary generator method, called by ProfilesController by request
  def as_json(*_args)
    RGeo::GeoJSON.encode factory.feature_collection(features)
  end

  # Wraps every Profile as a RGeo::GeoJSON feature
  def features
    decorated_collection.map(&:as_feature)
  end

  private

  # Accessor for the default RGeo::GeoJSON feature/s factory
  def factory
    RGeo::GeoJSON::EntityFactory.instance
  end
end
