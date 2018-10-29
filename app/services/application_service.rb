# Base service class.

class ApplicationService
  # Every service should be called from the class method, which then
  # instantiates and calls itself.
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
