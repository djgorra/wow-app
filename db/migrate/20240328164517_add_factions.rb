class AddFactions < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :faction, :integer
    add_column :teams, :faction, :integer
  end
end
