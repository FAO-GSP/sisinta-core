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
  validates :identifier, uniqueness: { scope: :user_id, allow_nil: true }
  validates :type, presence: true
  validates :license, presence: true

  accepts_nested_attributes_for :location, :layers

  after_initialize :set_default_value_objects

  scope :public_ones, ->{ where(public: true) }
  scope :geolocated, ->{ joins(:location).where('locations.coordinates is not ?', nil) }

  delegate :coordinates, :geolocated?, to: :location, allow_nil: true

  private

  # Initialize with default value objects
  def set_default_value_objects
    self.type ||= ProfileType.default
    self.license ||= License.default
  end
end
