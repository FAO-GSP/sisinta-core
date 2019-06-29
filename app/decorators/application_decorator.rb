# Define methods for all decorated objects.

class ApplicationDecorator < Draper::Decorator
  # Delegate every undefined method to the decorated object.
  delegate_all

  # Use the pagination decorator for every model collection.
  def self.collection_decorator_class
    PaginationDecorator
  end

  # Creates an identifier using information available to every model.
  def last_resort_identifier
    "#{model_name.human} #{object.to_param}"
  end
end
