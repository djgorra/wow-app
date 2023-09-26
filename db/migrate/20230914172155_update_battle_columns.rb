class UpdateBattleColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :battles, :team_raid_id, :run_id
    add_column :battles, :boss_id, :integer
  end
end
