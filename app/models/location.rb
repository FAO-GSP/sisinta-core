# Profile location data, notably [latitude, longitude] coordinates
class Location < ApplicationRecord
  belongs_to :profile

  attr_accessor :latitude, :longitude

  validates :profile, presence: true, uniqueness: true

  after_initialize :load_latitude_and_longitude
  before_save :update_coordinates

  def self.factory
    RGeo::ActiveRecord::SpatialFactoryStore.instance.default
  end

  private

  # Updates the geolocation column with provided [longitude, latitude] values
  def update_coordinates
    if longitude.present? && latitude.present?
      self.coordinates = Location.factory.point longitude, latitude
    end
  end

  # Loads virtual attributes from the DB values
  def load_latitude_and_longitude
    self.latitude = coordinates.try :latitude
    self.longitude = coordinates.try :longitude
  end
end
