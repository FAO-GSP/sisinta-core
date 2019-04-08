class RemoveDescriptionFromMetadataType < ActiveRecord::Migration[5.2]
  def change
    remove_column :metadata_types, :description, :text
  end
end
