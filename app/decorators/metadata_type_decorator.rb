# MetadataType presentation methods.

class MetadataTypeDecorator < ApplicationDecorator
  def display_name
    value
  end
end
