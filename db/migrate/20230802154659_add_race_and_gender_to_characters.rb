class AddRaceAndGenderToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :race, :integer
    add_column :characters, :gender, :integer
  end
end
