class Review < ActiveRecord::Base
  
  belongs_to  :company
  belongs_to  :user
  has_many    :review_issues
  has_many    :issues, :through => :review_issues
  has_many    :peer_ratings

  validates_presence_of :user_id
  
  # Define State Machine states and transitions
  include AASM
  
  aasm_column :status
  aasm_state :preview
  aasm_state :draft
  aasm_state :published
  aasm_initial_state :preview
  
  def build_issues(hash)
    for issue_id in hash.values.uniq
      review_issue = ReviewIssue.new(:issue_id => issue_id, :review_id => id)
      review_issue.save
    end
  end
  
  aasm_event :preview do
    transitions :to => :preview, :from => :draft
  end
  
  aasm_event :save_as_draft do
    transitions :to => :draft, :from => :preview
  end
  
  aasm_event :publish do
    transitions :to => :published, :from => :preview
  end
  
  
end
