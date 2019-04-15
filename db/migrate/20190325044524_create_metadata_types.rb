class CreateMetadataTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :metadata_types do |t|
      t.string :field_name, null: false
      t.jsonb :translations, default: {}

      t.timestamps
    end
  end
end
