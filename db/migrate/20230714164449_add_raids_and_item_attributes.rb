class AddRaidsAndItemAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :raids do |t|
      t.string :name
      t.string :wow_id
    end

    create_table :raid_items do |t|
      t.belongs_to :raid
      t.belongs_to :item
    end

    add_column :items, :category, :string
    add_column :items, :subcategory, :string
    add_column :items, :source, :string
    add_column :items, :item_level, :integer
  end
end
