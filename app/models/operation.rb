# An enqueued and potentially long operation with Profiles. An Operation can
# pure (true by default) or not, meaning it has side effects and we should bust
# the caches after it runs.

class Operation < ApplicationRecord
  # Acts as a State Machine.
  include AASM

  belongs_to :user
  has_one_attached :results

  validates :name, presence: true

  scope :latest, ->{ order(created_at: :desc).limit(10) }

  aasm column: 'state' do
    state :new, initial: true
    state :queued
    state :running
    state :failed
    state :completed

    event :enqueue do
      transitions from: :new, to: :queued
    end

    event :start do
      transitions from: [:queued, :running], to: :running
    end

    event :fail do
      transitions from: :running, to: :failed
    end

    event :complete do
      transitions from: :running, to: :completed
    end

    event :retry do
      transitions from: [:failed, :completed], to: :running
    end
  end
end
