class AddVersionIdsToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :raids, :version_id, :integer
    add_column :bosses, :version_id, :integer
    add_column :items, :version_id, :integer
    add_column :characters, :version_id, :integer
    add_index :items, :version_id
    add_column :raids, :zone_level, :integer
  end
end
