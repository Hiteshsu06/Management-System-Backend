class RemoveCompanyIdFromStocks < ActiveRecord::Migration[7.2]
  def change
    remove_column :demo_stocks, :company_id
  end
end
