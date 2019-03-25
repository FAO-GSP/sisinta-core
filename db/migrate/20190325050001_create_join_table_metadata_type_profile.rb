class CreateJoinTableMetadataTypeProfile < ActiveRecord::Migration[5.2]
  def change
    create_join_table :metadata_types, :profiles do |t|
      t.index [:profile_id, :metadata_type_id], name: 'profile_metadata'
    end
  end
end
