class CreateTeamJoinTables < ActiveRecord::Migration[6.0]
  def change
    create_table :team_characters do |t|
      t.belongs_to :team, null: false, foreign_key: true
      t.belongs_to :character, null: false, foreign_key: true
      t.timestamps
    end

    create_table :character_battles do |t|
      t.belongs_to :character, null: false, foreign_key: true
      t.belongs_to :battle, null: false, foreign_key: true
    end

    remove_reference :drops, :battle, index: true, foreign_key: true

    change_table :drops do |t|
      t.belongs_to :character_battle, null: false, foreign_key: true
    end
  end
end
