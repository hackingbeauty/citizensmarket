class UserIssue < ActiveRecord::Base

  belongs_to :user
  belongs_to :issue
  
  validates_uniqueness_of :issue_id, :scope => :user_id

end
