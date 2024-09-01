class ChangeUserIdTypeInCompany < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :companies, :users
  end
end
