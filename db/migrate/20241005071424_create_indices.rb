class CreateIndices < ActiveRecord::Migration[7.2]
  def change
    create_table :indices do |t|
      t.string :name
      t.string :price
      t.integer :country_id
      t.integer :category_id

      t.timestamps
    end
  end
end
