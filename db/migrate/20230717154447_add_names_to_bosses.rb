class AddNamesToBosses < ActiveRecord::Migration[6.0]
  def change
    add_column :bosses, :name, :string
  end
end
