class ChangeSpecBuffsToSpells < ActiveRecord::Migration[6.0]
  def change
    rename_table :spec_buffs, :spells
    add_column :spells, :icon, :string
    add_column :spells, :description, :string
  end
end
