class RemoveFinishedFromOperations < ActiveRecord::Migration[5.2]
  def change
    remove_column :operations, :finished, :boolean
  end
end
