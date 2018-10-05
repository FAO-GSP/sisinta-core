class CreateLayers < ActiveRecord::Migration[5.2]
  def change
    create_table :layers do |t|
      t.references :profile, foreign_key: true
      t.string :identifier, null: false
      t.integer :top, null: false
      t.integer :bottom, null: false
      t.string :designation
      t.decimal :bulk_density
      t.decimal :ca_co3
      t.decimal :coarse_fragments
      t.decimal :ecec
      t.decimal :conductivity
      t.decimal :organic_carbon
      t.decimal :ph_h2o
      t.decimal :ph_kcl
      t.decimal :clay
      t.decimal :silt
      t.decimal :sand
      t.decimal :water_retention

      t.timestamps
    end
  end
end
