class ReviewIssue < ActiveRecord::Base
  
  belongs_to  :review
  belongs_to  :issue
  
end
