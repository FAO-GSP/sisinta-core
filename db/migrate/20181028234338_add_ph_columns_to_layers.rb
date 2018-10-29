class AddPhColumnsToLayers < ActiveRecord::Migration[5.2]
  def change
    rename_column :layers, :ph_h2o, :ph_h2o_1
    rename_column :layers, :ph_kcl, :ph_kcl_1
    add_column :layers, :ph_h2o_2_5, :decimal
    add_column :layers, :ph_kcl_2_5, :decimal
  end
end
