class AddMissingColumnTableNameToUsersTable < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :full_address, :string
    add_column :users, :gender, :string
  end

  def down
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :full_address
    remove_column :users, :gender
  end
end
