class UpdateCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :city, :string
    add_column :companies, :state,  :string
    add_column :companies, :country, :string
    add_column :companies, :zip, :integer
    add_column :companies, :barcode, :integer
  end

  def self.down
  end
end
