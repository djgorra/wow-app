class AddSpecializations < ActiveRecord::Migration[6.0]
  def change
    create_table :specializations do |t|
      t.string :name, null: false
      t.integer :role, null: false
      t.string :buffs, array: true, default: []
      t.string :debuffs, array: true, default: []
    end
  end
end
