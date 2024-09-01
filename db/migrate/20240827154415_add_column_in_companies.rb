class AddColumnInCompanies < ActiveRecord::Migration[7.2]
  def change
    add_column :companies, :user_id, :integer
  end
end
