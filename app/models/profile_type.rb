# ProfileTypes possible values
class ProfileType < ApplicationRecord
  has_many :profiles, inverse_of: :type, foreign_key: :type_id,
    dependent: :restrict_with_error

  validates :value, uniqueness: true, presence: true

  def self.default
    ProfileType.first
  end
end
