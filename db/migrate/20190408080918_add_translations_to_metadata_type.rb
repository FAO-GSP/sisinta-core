class AddTranslationsToMetadataType < ActiveRecord::Migration[5.2]
  def change
    add_column :metadata_types, :translations, :jsonb, default: {}
  end
end
