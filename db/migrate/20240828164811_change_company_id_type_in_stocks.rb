class ChangeCompanyIdTypeInStocks < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :stocks, :companies
  end
end
