class RemoveValueFromProfileType < ActiveRecord::Migration[5.2]
  def change
    remove_column :profile_types, :value, :string, null: false
  end
end
