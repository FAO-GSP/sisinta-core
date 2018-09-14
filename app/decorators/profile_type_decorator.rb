# ProfileType presentation methods
class ProfileTypeDecorator < ApplicationDecorator
  # Just return the value
  def to_s
    value
  end

  # Return a formatted value
  def value
    object.value.titleize
  end
end
