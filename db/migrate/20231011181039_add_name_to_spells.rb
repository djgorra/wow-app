class AddNameToSpells < ActiveRecord::Migration[6.0]
  def change
    add_column :spells, :name, :string
  end
end
