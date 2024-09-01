class CreateStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :stocks do |t|
      t.string :category
      t.string :brand_name
      t.string :model_number
      t.string :stock_name
      t.integer :product_qty
      t.integer :buy_price
      t.integer :sell_price
      t.integer :gst_number

      t.timestamps
    end
  end
end
