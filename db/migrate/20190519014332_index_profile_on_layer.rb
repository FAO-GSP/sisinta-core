class IndexProfileOnLayer < ActiveRecord::Migration[5.2]
  def change
    remove_index :layers, :profile_id
    add_index :layers, [:profile_id, :identifier], unique: true
  end
end
