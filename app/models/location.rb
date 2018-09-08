# Profile location data, notably coordinates
class Location < ApplicationRecord
  belongs_to :profile

  validates :profile, presence: true, uniqueness: true

  def self.factory
    RGeo::ActiveRecord::SpatialFactoryStore.instance.default
  end
end
