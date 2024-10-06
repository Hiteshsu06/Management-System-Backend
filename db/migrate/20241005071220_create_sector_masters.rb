class CreateSectorMasters < ActiveRecord::Migration[7.2]
  def change
    create_table :sector_masters do |t|
      t.string :name
      t.string :price

      t.timestamps
    end
  end
end
