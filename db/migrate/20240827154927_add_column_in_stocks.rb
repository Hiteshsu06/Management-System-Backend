class AddColumnInStocks < ActiveRecord::Migration[7.2]
  def change
    add_column :stocks, :company_id, :integer
  end
end
