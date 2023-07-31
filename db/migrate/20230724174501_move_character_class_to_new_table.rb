class MoveCharacterClassToNewTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :characters, :character_class

    create_table :character_classes do |t|
      t.string :name, null: false
    end

    add_reference :characters, :character_class, foreign_key: true
    add_reference :specializations, :character_class, foreign_key: true
  end
end
