class AddItemsToDrops < ActiveRecord::Migration[6.0]
  def change
    add_column :drops, :item_id, :integer
  end
end
