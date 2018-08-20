class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.date :date
      t.references :user, foreign_key: true, null: false
      t.boolean :public, default: true
      t.string :user_defined_id
      t.string :order

      t.timestamps
    end
  end
end
