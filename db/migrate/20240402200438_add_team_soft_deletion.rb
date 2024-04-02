class AddTeamSoftDeletion < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :deleted, :boolean, default: false
  end
end
