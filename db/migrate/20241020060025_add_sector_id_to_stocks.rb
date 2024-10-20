class AddSectorIdToStocks < ActiveRecord::Migration[7.2]
  def change
    add_reference :stocks, :sector_masters, foreign_key: true
  end
end
