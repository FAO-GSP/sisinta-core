# Creates GeoJSON Features from a Profile, ready to be serialized
class GeojsonDecorator < ProfileDecorator
  decorates :profile

  # Use this class for collection decoration
  def self.collection_decorator_class
    GeojsonCollectionDecorator
  end

  # Wraps the decorated Profile as an RGeo::GeoJSON feature
  def as_feature
    factory.feature object.coordinates, object.id, properties
  end

  # Returns a hash of serializable properties 
  def properties
    {
      id: object.id,
      public: object.public,
      identifier: identifier,

      url: h.profile_url(object)
    }
  end

  private

  # Accessor for the default RGeo::GeoJSON feature/s factory
  def factory
    RGeo::GeoJSON::EntityFactory.instance
  end
end
