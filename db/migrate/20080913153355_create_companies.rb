class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies, :force => true do |t|
      t.string  :name
      t.string  :stock_symbol
      t.text    :description
      t.string  :logo_url
      t.string  :website_url
      t.integer :google_cid
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
