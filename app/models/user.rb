# A visitor of the system.

class User < ApplicationRecord
  # Devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable

  # :guest by default on initialization, :registered on creation
  # Each role should have a corresponding set of rules on Ability
  enum role: [:guest, :registered, :authorized, :admin]

  has_many :profiles, dependent: :restrict_with_error
  has_many :operations, dependent: :destroy

  validates :name, presence: true

  after_save :grant_registered_role
  before_save :check_selected_profiles_for_existance

  scope :admins, ->{ where role: :admin }

  # Enforce an array of integers, remove duplicate ids and order them.
  def current_selection=(value)
    super (Array.wrap(value).map(&:to_i) & Profile.ids).uniq.sort
  end

  # Only return selected profiles which exist in the database.
  def clean_current_selection
    current_selection & Profile.ids
  end

  private

  # To every new registered user.
  def grant_registered_role
    self.registered! if persisted? && guest?
  end

  # Trims selected profiles to those still exising in the database.
  # FIXME Rewrite somehow to avoid triggering on each Profile initialization.
  def check_selected_profiles_for_existance
    self.current_selection = current_selection & Profile.ids
  end
end
