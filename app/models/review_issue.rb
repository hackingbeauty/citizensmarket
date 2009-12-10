class ReviewIssue < ActiveRecord::Base
  
  belongs_to  :review
  belongs_to  :issue
  
  validates_uniqueness_of :review_id, :scope => :issue_id
  
end
