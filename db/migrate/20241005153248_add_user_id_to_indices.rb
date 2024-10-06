class AddUserIdToIndices < ActiveRecord::Migration[7.2]
  def change
    add_column :indices, :user_id, :integer
  end
end
