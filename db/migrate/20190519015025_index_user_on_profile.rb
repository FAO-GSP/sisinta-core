class IndexUserOnProfile < ActiveRecord::Migration[5.2]
  def change
    remove_index :profiles, :user_id
    add_index :profiles, [:user_id, :identifier], unique: true
  end
end
