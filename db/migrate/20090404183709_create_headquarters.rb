class CreateHeadquarters < ActiveRecord::Migration
  def self.up
    create_table :headquarters do |t|
      t.string  :address    
      t.string  :city      
      t.string  :state       
      t.string  :zipcode     
      t.string  :country     
      t.integer :company_id 
      t.timestamps
    end
  end

  def self.down
    drop_table :headquarters
  end
end