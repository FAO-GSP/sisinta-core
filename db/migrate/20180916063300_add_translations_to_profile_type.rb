class AddTranslationsToProfileType < ActiveRecord::Migration[5.2]
  def change
    add_column :profile_types, :translations, :jsonb, default: {}
  end
end
