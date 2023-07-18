class ChangeRaidItemsToBosses < ActiveRecord::Migration[6.0]
  def change
    drop_table :raid_items
    create_table :bosses do |t|
      t.belongs_to :raid
    end
    
    add_reference :items, :boss, foreign_key: true
    add_reference :items, :raid, foreign_key: true
  end
end
