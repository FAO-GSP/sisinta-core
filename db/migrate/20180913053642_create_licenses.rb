class CreateLicenses < ActiveRecord::Migration[5.2]
  def change
    create_table :licenses do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :acronym, null: false
      t.string :statement, null: false
      t.boolean :default, default: false, null: false
    end
  end
end
