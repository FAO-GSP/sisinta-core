# Imports View helpers.

module ImportsHelper
  # Generates a select with the metadata types for the provided field name.
  def select_metadata_tag(field)
    select_tag 'import[metadata][]',
      options_from_collection_for_select(MetadataType.for(field), :id, :value, selected_for(field)),
      id: "metadata_#{field}", class: 'form-control', include_blank: true
  end

  # Deduce which id from the metadata array is relevant for the provided field.
  def selected_for(field)
    (import.metadata.map(&:to_i) & MetadataType.for(field).ids).first
  end

  private

  # Reuse instance variable from controller.
  def import
    @import
  end
end
