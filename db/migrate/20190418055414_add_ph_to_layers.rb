class AddPhToLayers < ActiveRecord::Migration[5.2]
  def change
    add_column :layers, :ph, :decimal
  end
end
