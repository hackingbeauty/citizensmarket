class CreateReviewIssues < ActiveRecord::Migration
  def self.up
    create_table :review_issues do |t|
      t.references  :review
      t.references  :issue
      t.timestamps
    end
  end

  def self.down
    drop_table :review_issues
  end
end
