# ProfileTypes possible values
class ProfileType < ApplicationRecord
  extend Mobility
  # TODO Investigate why this line breaks db creation from zero
  # https://github.com/shioyama/mobility/issues/300
  translates :value

  has_many :profiles, inverse_of: :type, foreign_key: :type_id,
    dependent: :restrict_with_error

  validates :value, uniqueness: true, presence: true
  validate :always_a_default

  before_save :ensure_only_one_default

  def self.default
    ProfileType.where(default: true).first
  end

  # How to display this model in ActiveAdmin. Here and not in a decorator
  # because it's loaded without one in filters.
  def display_name
    value
  end

  private

  # Prevents leaving the app without a default ProfileType
  def always_a_default
    # i18n-tasks-use t('activerecord.errors.models.profile_type.attributes.default.there_must_be_a_default_profile_type')
    errors.add(:default, :there_must_be_a_default_profile_type) if ProfileType.where(default: true).empty? && !default?
  end

  # If this is the new default, update the previous one
  def ensure_only_one_default
    ProfileType.update_all(default: false) if default? && default_changed?
  end
end
