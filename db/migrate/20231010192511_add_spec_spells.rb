class AddSpecSpells < ActiveRecord::Migration[6.0]
  def change
    create_table :spec_spells do |t|
      t.belongs_to :specialization
      t.belongs_to :spell
    end
  end
end
