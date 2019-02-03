class AddErrorMessageToOperations < ActiveRecord::Migration[5.2]
  def change
    add_column :operations, :error_message, :string
  end
end
