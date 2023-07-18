class RemoveItemSource < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :source
  end
end
