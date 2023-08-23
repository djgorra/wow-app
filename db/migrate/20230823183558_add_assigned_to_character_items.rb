class AddAssignedToCharacterItems < ActiveRecord::Migration[6.0]
  def change
    add_column :character_items, :assigned, :boolean, default: false
  end
end
