class AddLicenseToProfile < ActiveRecord::Migration[5.2]
  def change
    add_reference :profiles, :license, index: true, foreign_key: true
  end
end
