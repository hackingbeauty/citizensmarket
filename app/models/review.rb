class Review < ActiveRecord::Base
  
  belongs_to  :company
  belongs_to  :user
  has_many    :review_issues
  has_many    :issues, :through => :review_issues
  has_many    :peer_ratings

  validates_presence_of :user_id, :rating
  
  # Define State Machine states and transitions
  include AASM
  
  aasm_column :status
  aasm_state :preview
  aasm_state :draft
  aasm_state :published
  aasm_initial_state :preview
  
  ##########################################################
  ######## SCORING SYSTEM
  
  def review_score
    # return cached if cached
    output = 0
    peer_ratings.each do |pr|
      output += pr.score
    end
    output
  end
  
  def non_negative_quality_factor
    qf = quality_factor
    y = non_negative_quality_factor_y
    
    (Math.exp(qf)/(Math.exp(1) - y)**qf)
  end
  def non_negative_quality_factor_y
    0.07
  end
    
  def quality_factor
    # return cached if it exists
    y = Review.quality_factor_y
    output = user.contributor_level + (y * review_score)
    output = 0 if output < 0
    output
  end
  def self.quality_factor_y
    1
  end
  ######## end SCORING SYSTEM
  ##########################################################
  
  
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
