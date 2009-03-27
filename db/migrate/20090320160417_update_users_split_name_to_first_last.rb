class UpdateUsersSplitNameToFirstLast < ActiveRecord::Migration
  def self.up
  
    remove_column :users, :name
    add_column :users, :firstname, :string, :limit => 100, :default => ""
    add_column :users, :lastname, :string, :limit => 100, :default => ""
  
  end

  def self.down
    
    add_column :users, :name, :string, :limit => 100, :default => ""
    remove_column :users, :firstname
    remove_column :users, :lastname
    
  end
end
