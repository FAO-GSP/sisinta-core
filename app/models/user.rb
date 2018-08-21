# A visitor of the system.

class User < ApplicationRecord
  # Devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable

  scope :admins, ->{ where admin: true }

  validates :name, presence: true
end
