# A Profile is the main model of the system. It represent a soil profile or
# similar point of interest.
class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :type, inverse_of: :profiles, class_name: 'ProfileType'
  has_one :location, dependent: :destroy

  validates :user, presence: true
  validates :source, presence: true
  validates :identifier, uniqueness: { scope: :user_id, allow_nil: true }

  accepts_nested_attributes_for :location

  after_initialize :set_default_value_objects

  private

  # Initialize with default value objects
  def set_default_value_objects
    self.type ||= ProfileType.default
  end
end
