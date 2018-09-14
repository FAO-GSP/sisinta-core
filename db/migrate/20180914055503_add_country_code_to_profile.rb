class AddCountryCodeToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :country_code, :string, null: false
  end
end
