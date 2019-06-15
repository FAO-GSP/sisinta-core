# MetadataEntry presentation methods

class MetadataEntryDecorator < ApplicationDecorator
  decorates_association :profile
  decorates_association :metadata_type

  def display_name
    field_name
  end
end
