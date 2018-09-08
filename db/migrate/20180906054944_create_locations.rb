class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.st_point :coordinates, geographic: true
      t.references :profile, foreign_key: true

      t.timestamps
    end
    add_index :locations, :coordinates, using: :gist
  end
end
