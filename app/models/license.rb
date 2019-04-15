# The license for a specific Profile data
class License < ActiveRecord::Base
  has_many :profiles, inverse_of: :license,
    dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :acronym, presence: true, uniqueness: true
  validates :statement, presence: true, uniqueness: true
  validates :default, inclusion: { in: [true, false] }
  validate :always_a_default

  before_save :ensure_only_one_default

  # Returns the default license. The specific license can be changed from admin
  # panel
  def self.default
    License.where(default: true).first
  end

  private

  # Prevents leaving the app without a default License
  # i18n-tasks-use t('activerecord.errors.models.license.attributes.default.there_must_be_a_default_license')
  def always_a_default
    errors.add(:default, :there_must_be_a_default_license) if License.where(default: true).empty? && !default?
  end

  # If this is the new default, update the previous one
  def ensure_only_one_default
    License.update_all(default: false) if default? && default_changed?
  end
end
