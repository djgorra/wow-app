class AddApiFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :wow_id, :integer
    add_column :users, :battletag, :string
    add_column :users, :access_token, :string
    add_column :users, :access_token_expires_at, :datetime
    add_column :users, :access_token_hash, :string
  end
end
