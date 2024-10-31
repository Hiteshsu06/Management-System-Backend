class ChangeGstTypeToDemoStocksTable < ActiveRecord::Migration[7.2]
  def up
    change_column :demo_stocks, :gst_number, :string
  end

  def down
      change_column :demo_stocks, :gst_number, :integer
  end
end
