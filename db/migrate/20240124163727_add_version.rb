class AddVersion < ActiveRecord::Migration[6.0]
  def change
    create_table :versions do |t|
      t.string :version_name
    end
  end
end
