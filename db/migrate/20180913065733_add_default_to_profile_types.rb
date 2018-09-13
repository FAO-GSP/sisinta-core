class AddDefaultToProfileTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :profile_types, :default, :boolean, default: false, null: false
  end
end
