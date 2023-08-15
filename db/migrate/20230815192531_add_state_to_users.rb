class AddStateToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uuid, :string
    remove_column :users, :access_token
    remove_column :users, :access_token_expires_at
    remove_column :users, :access_token_hash
  end
end
