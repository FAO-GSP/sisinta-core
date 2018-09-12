class AddSourceToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :source, :string, null: false
  end
end
