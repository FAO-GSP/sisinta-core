# Define methods for all decorated objects.
class ApplicationDecorator < Draper::Decorator
  # Delegate every undefined method to the decorated object
  delegate_all
end
