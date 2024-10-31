class DeleteColumnFromUsersTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :profile_image
  end
end
