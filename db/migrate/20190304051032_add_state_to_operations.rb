class AddStateToOperations < ActiveRecord::Migration[5.2]
  def change
    add_column :operations, :state, :string
  end
end
