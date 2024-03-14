class CreateTeamCodeCharactersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :team_code_characters do |t|
      t.integer :team_id
      t.integer :character_id
    end
  end
end
