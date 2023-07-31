class AddSpecializationToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_reference :characters, :primary_spec, foreign_key: { to_table: :specializations }
    add_reference :characters, :secondary_spec, foreign_key: { to_table: :specializations }
  end
end
