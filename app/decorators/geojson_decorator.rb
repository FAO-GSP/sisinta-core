# Creates GeoJSON Features from a Profile, ready to be serialized.

class GeojsonDecorator < ProfileDecorator
  include GeojsonSerializer

  decorates :profile

  # Use this class for collection decoration.
  def self.collection_decorator_class
    GeojsonCollectionDecorator
  end

  # Wraps this Profile as a RGeo::GeoJSON feature. Called by `as_json` from
  # ProfilesController.
  def features
    [as_feature]
  end

  # Wraps the decorated Profile as an RGeo::GeoJSON feature.
  def as_feature
    # Caches generated GeoJSON until touched
    Rails.cache.fetch ['geojson_decorator', object] do
      factory.feature object.coordinates, object.id, properties
    end
  end

  # Returns a hash of serializable properties.
  def properties
    {
      id: object.id,
      public: object.public,
      identifier: identifier,

      url: h.profile_url(object)
    }
  end
end
