class RenameCharacterItems < ActiveRecord::Migration[6.0]
  def change
    rename_table :characters_items, :character_items
  end
end
