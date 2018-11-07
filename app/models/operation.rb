# An enqueued and potentially long operation with Profiles.

class Operation < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
end
