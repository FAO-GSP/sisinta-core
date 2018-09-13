# A Profile is the main model of the system. It represent a soil profile or
# similar point of interest.
class Profile < ApplicationRecord
  belongs_to :user
  has_one :location, dependent: :destroy

  validates :user, presence: true
  validates :source, presence: true
  validates :identifier, uniqueness: { scope: :user_id, allow_nil: true }

  accepts_nested_attributes_for :location
end
