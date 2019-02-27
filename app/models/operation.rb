# An enqueued and potentially long operation with Profiles. An Operation can
# pure (true by default) or not, meaning it has side effects and we should bust
# the caches after it runs.

class Operation < ApplicationRecord
  belongs_to :user
  has_one_attached :results

  validates :name, presence: true

  scope :latest, ->{ order(created_at: :desc).limit(10) }
end
