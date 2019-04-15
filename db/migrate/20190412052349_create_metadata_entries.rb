class CreateMetadataEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :metadata_entries do |t|
      t.references :profile, foreign_key: true
      t.references :metadata_type, foreign_key: true

      t.timestamps
    end

    add_index :metadata_entries, [:profile_id, :metadata_type_id], unique: true
  end
end
