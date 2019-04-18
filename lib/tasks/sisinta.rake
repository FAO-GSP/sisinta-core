# Sisinta custom tasks.

namespace :sisinta do
  namespace :operations do
    # Clean up old operations.
    desc 'Clean up operations older than a week'
    task cleanup: :environment do
      Operation.where('created_at < ?', 7.days.ago).destroy_all
    end
  end

  namespace :metadata do
    desc 'Update metadata for ph'
    task update: :environment do
      # MetadataType ids for old column names.
      ph_types = {
        ph_h2o_1: 24,
        ph_h2o_2_5: 25,
        ph_kcl_1: 27,
        ph_kcl_2_5: 28
      }

      Profile.find_each do |profile|
        # Skip this profile if already has metadata
        next if profile.metadata_for(:ph).present?

        ph_types.each do |type, id|

          # If every layer has a value for this ph type.
          if profile.layers.all? { |layer| layer.send(type).present? }
            # Copy the ph values to the new column.
            profile.layers.each do |layer|
              layer.update ph: layer.send(type)
            end

            # Saves the metadata and stop checking for types.
            profile.metadata_entries.create metadata_type_id: id
            break
          end
        end
      end
    end
  end
end
