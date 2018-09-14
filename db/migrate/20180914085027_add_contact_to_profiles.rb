class AddContactToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :contact, :string
  end
end
