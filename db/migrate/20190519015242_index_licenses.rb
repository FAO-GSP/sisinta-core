class IndexLicenses < ActiveRecord::Migration[5.2]
  def change
    change_table :licenses do |t|
      t.index :name, unique: true
      t.index :url, unique: true
      t.index :acronym, unique: true
      t.index :statement, unique: true
    end
  end
end
