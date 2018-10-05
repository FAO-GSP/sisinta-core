# Layer presentation methods
class LayerDecorator < ApplicationDecorator
  decorates_association :profile

  def display_name
    identifier
  end
end
