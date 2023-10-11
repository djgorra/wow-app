class MoveBuffsToTable < ActiveRecord::Migration[6.0]
  def change
    create_table :buffs do |t|
      t.string :name
      t.string :description
      t.string :icon
      t.string :type
    end

    create_table :spec_buffs do |t|
      t.belongs_to :specialization
      t.belongs_to :buff
    end

    remove_column :specializations, :buffs
    remove_column :specializations, :debuffs
  end


end
