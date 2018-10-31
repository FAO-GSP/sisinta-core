# Each horizontal layer of a Profile, with analytical data
class Layer < ApplicationRecord
  belongs_to :profile, touch: true

  validates :identifier, presence: true,
    uniqueness: { scope: :profile_id }

  # How they are usually accessed from a Profile
  scope :from_top_to_bottom, ->{ order(top: :asc, bottom: :asc) }
end
