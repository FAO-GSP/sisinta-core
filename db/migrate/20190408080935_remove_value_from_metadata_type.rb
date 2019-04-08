class RemoveValueFromMetadataType < ActiveRecord::Migration[5.2]
  def change
    remove_column :metadata_types, :value, :string, null: false
  end
end
