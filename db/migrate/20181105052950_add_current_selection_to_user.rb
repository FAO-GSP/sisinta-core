class AddCurrentSelectionToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_selection, :integer, array: true, default: []
  end
end
