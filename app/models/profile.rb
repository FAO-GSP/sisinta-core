# A Profile is the main model of the system. It represent a soil profile or
# similar point of interest.
class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :type, inverse_of: :profiles, class_name: 'ProfileType'
  belongs_to :license
  has_one :location, dependent: :destroy
  has_many :layers, dependent: :destroy
  # Associative model instead of a HABTM relationship for validation purposes.
  has_many :metadata_entries, dependent: :destroy
  has_many :metadata_types, through: :metadata_entries

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

  # Generates Metadata Entries for each Metadata Type id in the array passed,
  # replacing existing ones.
  def metadata=(type_ids)
    return if !type_ids.present?

    self.metadata_entries.destroy_all
    MetadataType.where(id: type_ids).each do |type|
      self.metadata_entries.build metadata_type: type
    end
  end

  # Return the unique associated metadata type for the provided field, for this
  # profile.
  def metadata_for(field)
    metadata_types.for(field).first.try :value
  end

  private

  # Initialize with default value objects
  def set_default_value_objects
    self.type = ProfileType.default if self.type_id.nil?
    self.license = License.default if self.license_id.nil?
  end
end
