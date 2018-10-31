class RelaxLayerTopBottomRestrictions < ActiveRecord::Migration[5.2]
  def change
    change_column_null :layers, :top, true
    change_column_null :layers, :bottom, true
  end
end
