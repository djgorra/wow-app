class AddColumnsToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :image_url, :string
    add_column :items, :wow_id, :integer

    create_table :item_sets do |t|
      t.string :name
    end
  end
end
