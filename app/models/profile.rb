# A Profile is the main model of the system. It represent a soil profile or
# similar point of interest.
class Profile < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :identifier, uniqueness: { scope: :user_id, allow_nil: true }
end
