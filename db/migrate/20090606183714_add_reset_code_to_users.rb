class AddResetCodeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :reset_code, :int
  end

  def self.down
    remove_column :users, :reset_code
  end
end