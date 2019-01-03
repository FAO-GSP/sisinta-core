class AddProcessToOperations < ActiveRecord::Migration[5.2]
  def change
    add_column :operations, :process, :string
  end
end
