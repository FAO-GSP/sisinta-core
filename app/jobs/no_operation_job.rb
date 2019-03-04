# Logs an operation when the provided name is not allowed.

class NoOperationJob < ApplicationJob
  # Does nothing but respects the method signature for Operations and logs it
  # successfully.
  def perform(operation)
    operation.start!
    operation.complete!
  end
end
