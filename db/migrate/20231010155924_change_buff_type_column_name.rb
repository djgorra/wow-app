class ChangeBuffTypeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :buffs, :type, :effect_type
  end
end
