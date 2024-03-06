class AddInviteCodeToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :invite_code, :string
  end
end
