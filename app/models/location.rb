# Profile location data, notably [latitude, longitude] coordinates.

class Location < ApplicationRecord
  # Touch it's profile for cache busting.
  belongs_to :profile, touch: true

  attribute :latitude, :decimal
  attribute :longitude, :decimal

  validates :profile, presence: true, uniqueness: true

  # Latitudes are restricted to the range (-85.0511287, 85.0511287)
  # because it results in a square projected domain.
  # i18n-tasks-use t('activerecord.attributes.location.latitude')
  validates :latitude, numericality: {
    greater_than_or_equal_to: -85.0511287,
    less_than_or_equal_to: 85.0511287,
    allow_nil: true
  }
  # i18n-tasks-use t('activerecord.attributes.location.longitude')
  validates :longitude, numericality: {
    greater_than_or_equal_to: -180,
    less_than_or_equal_to: 180,
    allow_nil: true
  }

  after_initialize :load_latitude_and_longitude
  before_save :update_coordinates

  def self.factory
    RGeo::ActiveRecord::SpatialFactoryStore.instance.default
  end

  # For correct coordinates creation outside this model (i.e. from Profile).
  def self.generate_coordinates(longitude:, latitude:)
    factory.point longitude, latitude
  end

  def geolocated?
    coordinates.present?
  end

  private

  # Updates the geolocation column with provided [longitude, latitude] values.
  # FIXME This prevents setting coordinates to nil.
  def update_coordinates
    if longitude.present? && latitude.present?
      self.coordinates = Location.generate_coordinates(
        longitude: longitude,
        latitude: latitude
      )
    end
  end

  # Loads virtual attributes from the DB values.
  def load_latitude_and_longitude
    self.latitude = coordinates.try :latitude
    self.longitude = coordinates.try :longitude
  end
end
