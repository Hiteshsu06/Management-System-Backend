class AddProfileImageColumnTableNameToUsersTable < ActiveRecord::Migration[7.2]
  def up
    add_column :users, :profile_image, :string
  end

  def down
    remove_column :users, :profile_image
  end
end
