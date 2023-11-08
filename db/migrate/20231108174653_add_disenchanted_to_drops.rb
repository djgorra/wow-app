class AddDisenchantedToDrops < ActiveRecord::Migration[6.0]
  def change
    add_column :drops, :disenchanted, :boolean, :default => false
  end
end
