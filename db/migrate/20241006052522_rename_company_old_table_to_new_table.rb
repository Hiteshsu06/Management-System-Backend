class RenameCompanyOldTableToNewTable < ActiveRecord::Migration[7.2]
  def self.up
    rename_table :companies, :demo_companies
  end

  def self.down
    rename_table :demo_companies, :companies
  end
end
