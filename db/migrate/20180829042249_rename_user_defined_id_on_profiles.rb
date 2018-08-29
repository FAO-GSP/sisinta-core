class RenameUserDefinedIdOnProfiles < ActiveRecord::Migration[5.2]
  def change
    rename_column :profiles, :user_defined_id, :identifier
  end
end
