class CreateDrops < ActiveRecord::Migration[6.0]
  def change
    create_table :drops do |t|
      t.belongs_to :battle, null: false, foreign_key: true
      t.timestamps
    end
  end
end
