class AddUuidToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :uuid, :string
    
    add_index :profiles, :uuid, unique: true
  end
end
