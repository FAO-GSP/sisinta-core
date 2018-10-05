# Each horizontal layer of a Profile, with analytical data
class Layer < ApplicationRecord
  belongs_to :profile, touch: true

  validates :top, presence: true
  validates :bottom, presence: true
  validates :identifier, presence: true,
    uniqueness: { scope: :profile_id }
end
