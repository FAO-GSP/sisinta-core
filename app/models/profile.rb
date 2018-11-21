# A Profile is the main model of the system. It represent a soil profile or
# similar point of interest.
class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :type, inverse_of: :profiles, class_name: 'ProfileType'
  belongs_to :license
  has_one :location, dependent: :destroy
  has_many :layers, dependent: :destroy

  validates :user, presence: true
  validates :source, presence: true
  validates :country_code, presence: true,
    inclusion: { in: Rails.configuration.engine.default_country_codes }
  # FIXME Change scope to source
  validates :identifier, uniqueness: { scope: :user_id, allow_nil: true }
  validates :type, presence: true
  validates :license, presence: true
  validates :uuid, uniqueness: { allow_nil: true }

  accepts_nested_attributes_for :location, :layers

  after_initialize :set_default_value_objects

  scope :public_ones, ->{ where(public: true) }
  scope :geolocated, ->{ joins(:location).where('locations.coordinates is not ?', nil) }

  delegate :coordinates, :latitude, :longitude, :geolocated?, to: :location, allow_nil: true

  # Generates a UUID from (probably) unique values for this profile.
  def self.generate_uuid(country_code:, identifier:, source:, latitude:, longitude:)
    key = [country_code, identifier, source, latitude, longitude]

    Digest::MD5.hexdigest key.join
  end

  private

  # Initialize with default value objects
  def set_default_value_objects
    self.type ||= ProfileType.default
    self.license ||= License.default
  end
end
