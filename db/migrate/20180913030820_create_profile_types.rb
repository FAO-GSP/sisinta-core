class CreateProfileTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_types do |t|
      t.string :value, null: false
    end
  end
end
