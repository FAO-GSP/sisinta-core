# A collection of Profiles decorated with GeojsonProfileDecorator for geojson
# serialization.

class GeojsonCollectionDecorator < Draper::CollectionDecorator
  include GeojsonSerializer

  # Use this class for item decoration.
  def decorator_class
    GeojsonProfileDecorator
  end

  # Wraps every Profile as a RGeo::GeoJSON feature. Called by `as_json` from
  # ProfilesController.
  def features
    collected_features = []
    # Don't load full models into memory when only the `geojson` field is
    # needed.
    object.in_batches do |profiles|
      collected_features += profiles.pluck(:geojson)
    end

    collected_features
  end
end
