class AddCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.timestamps
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :character_class, null: false
    end

    create_table :characters_items do |t|
      t.belongs_to :character, null: false, foreign_key: true
      t.belongs_to :item, foreign_key: true
    end
  end
end
