class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.integer :contact_number
      t.string :gst_number

      t.timestamps
    end
  end
end