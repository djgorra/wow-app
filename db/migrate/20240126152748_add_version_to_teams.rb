class AddVersionToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :version_id, :integer
    add_index :teams, :version_id
  end
end
