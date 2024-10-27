class AddColumnTableNameToUsersTable < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :role, :string
    add_column :users, :google_token, :string
    add_column :users, :facebook_token, :string
  end

  def down
    remove_column :users, :role, :string
    remove_column :users, :google_token, :string
    remove_column :users, :facebook_token, :string
  end
end
