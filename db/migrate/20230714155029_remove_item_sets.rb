class RemoveItemSets < ActiveRecord::Migration[6.0]
  def change
    drop_table :item_sets
  end
end
