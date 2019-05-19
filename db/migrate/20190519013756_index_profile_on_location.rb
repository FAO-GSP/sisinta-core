class IndexProfileOnLocation < ActiveRecord::Migration[5.2]
  def change
    remove_index :locations, :profile_id
    add_index :locations, :profile_id, unique: true
  end
end
