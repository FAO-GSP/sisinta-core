# A visitor of the system.

class User < ApplicationRecord
  # Devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable

  has_many :profiles, dependent: :restrict_with_error

  scope :admins, ->{ where admin: true }

  validates :name, presence: true
end
