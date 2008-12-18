class CreateUserIssues < ActiveRecord::Migration
  def self.up
    create_table :user_issues do |t|
      t.integer :user_id
      t.integer :issue_id
      t.integer :weight
      
      t.timestamps
    end
  end

  def self.down
    drop_table :user_issues
  end
end
