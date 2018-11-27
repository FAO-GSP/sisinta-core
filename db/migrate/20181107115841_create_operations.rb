class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.boolean :finished, default: false
      t.references :user, index: true, foreign_key: true
      t.integer :profile_ids, array: true, default: []
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
