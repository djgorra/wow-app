class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|

      t.timestamps
      t.integer :user_id
      t.integer :friend_id
    end
  end
end
