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
  validate :one_metadata_entry_per_type

  accepts_nested_attributes_for :location, :layers

  after_initialize :set_default_value_objects
  after_save :generate_geojson, if: :geolocated?
  after_touch :generate_geojson, if: :geolocated?

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

  # Initialize with default value objects.
  def set_default_value_objects
    self.type = ProfileType.default if self.type_id.nil?
    self.license = License.default if self.license_id.nil?
  end

  # Pregenerate and cache a GeoJSON representation of this Profile.
  def generate_geojson
    update_column :geojson, GeojsonProfileDecorator.new(self).as_encoded_feature
  end

  # Do not allow more than one Entry per field_name in MetadataType for this Profile.
  # i18n-tasks-use t('activerecord.errors.models.profile.attributes.metadata_entries.fields_cant_have_more_than_one_entry')
  def one_metadata_entry_per_type
    field_names = metadata_entries.collect { |entry| entry.metadata_type.field_name }

    unless field_names == field_names.uniq
      errors.add :metadata_entries, :fields_cant_have_more_than_one_entry
    end
  end
end
