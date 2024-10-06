class AddCompanyIdToStocks < ActiveRecord::Migration[7.2]
  def change
    add_reference :demo_stocks, :demo_company, foreign_key: true
  end
end
