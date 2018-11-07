# An enqueued and potentially long operation with Profiles.

class Operation < ApplicationRecord
  belongs_to :user
  has_one_attached :results

  validates :name, presence: true
end
