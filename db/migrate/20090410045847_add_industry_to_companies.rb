class AddIndustryToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :industry, :string
  end

  def self.down
  end
end
