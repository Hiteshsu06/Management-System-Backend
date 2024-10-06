class RemoveColumnsFromStocks < ActiveRecord::Migration[7.2]
  def change
    remove_column :stocks, :category
    remove_column :stocks, :brand_name
    remove_column :stocks, :model_number
    remove_column :stocks, :stock_name
    remove_column :stocks, :product_qty
    remove_column :stocks, :buy_price
    remove_column :stocks, :sell_price
    remove_column :stocks, :gst_number
    remove_column :stocks, :company_id
    add_column :stocks, :name, :string
    add_column :stocks, :price, :string
  end
end
