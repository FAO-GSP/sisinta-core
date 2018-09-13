class AddTypeToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_reference :profiles, :type, foreign_key: { to_table: :profile_types }, index: true
  end
end
