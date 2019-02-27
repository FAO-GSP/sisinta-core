class AddPureToOperation < ActiveRecord::Migration[5.2]
  def change
    add_column :operations, :pure, :boolean, default: true
  end
end
