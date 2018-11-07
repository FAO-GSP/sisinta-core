# A visitor of the system.

class User < ApplicationRecord
  # Devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable

  # :guest by default on initialization, :registered on creation
  # Each role should have a corresponding set of rules on Ability
  enum role: [:guest, :registered, :authorized, :admin]

  has_many :profiles, dependent: :restrict_with_error

  validates :name, presence: true

  after_save :grant_registered_role

  scope :admins, ->{ where role: :admin }

  # Enforce an array, remove duplicate ids and order them.
  def current_selection=(value)
    super Array.wrap(value).uniq.sort
  end

  private

  # To every new registered user.
  def grant_registered_role
    self.registered! if persisted? && guest?
  end
end
