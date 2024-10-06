class AddUserIdToSectorMasters < ActiveRecord::Migration[7.2]
  def change
    add_column :sector_masters, :user_id, :integer
  end
end
