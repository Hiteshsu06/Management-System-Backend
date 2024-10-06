class CreateDemoStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :demo_stocks do |t|
      t.string :brand_name
      t.string :category
      t.string :model_number
      t.string :stock_name
      t.integer :product_qty
      t.integer :buy_price
      t.integer :sell_price
      t.integer :gst_number
      t.integer :company_id

      t.timestamps
    end
  end
end
