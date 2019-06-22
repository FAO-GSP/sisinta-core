# Associative model between Profile and its Metadata Types instead of a HABTM
# relationship for validation purposes.
class MetadataEntry < ApplicationRecord
  belongs_to :profile
  belongs_to :metadata_type

  # Do not allow repeated pairs of [profile, metadata_type].
  validates :metadata_type_id, uniqueness: { scope: :profile_id }
  validate :one_entry_per_profile_field

  delegate :field_name, :value, to: :metadata_type

  # Do not allow more than one Entry per field_name in MetadataType for this Profile.
  # i18n-tasks-use t('activerecord.errors.models.metadata_entry.attributes.metadata_type.fields_cant_have_more_than_one_entry')
  def one_entry_per_profile_field
    metadata = profile.metadata_types.for(metadata_type.field_name)
    # Allow replacing the metadata_type_id for this entry to work from ActiveAdmin
    if metadata.where.not(metadata_entries: metadata_type_id_was).any?
      errors.add :metadata_type, :fields_cant_have_more_than_one_entry
    end
  end
end
