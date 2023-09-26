class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.timestamps
    end

    create_table :team_raids do |t|
      t.belongs_to :team, null: false, foreign_key: true
      t.belongs_to :raid, null: false, foreign_key: true
      t.timestamps
    end

    create_table :battles do |t|
      t.belongs_to :team_raid, null: false, foreign_key: true
      t.timestamps
    end
  end
end
