class Review < ActiveRecord::Base
  
  belongs_to  :company, :counter_cache => true
  belongs_to  :user
  has_many    :review_issues
  has_many    :issues, :through => :review_issues
  has_many    :peer_ratings

  validates_presence_of :user_id, :rating, :status
  validate_on_create :protect_against_angry_abuse
  
  validates_inclusion_of :rating, :in => (0.5 .. 5.0)
  
  before_validation :set_initial_state, :on => :create
  
  # Define State Machine states and transitions
  include AASM
  
  aasm_initial_state :preview
  aasm_column :status
  aasm_state :preview
  aasm_state :draft
  aasm_state :published
  aasm_event :preview do
    transitions :to => :preview, :from => :draft
  end
  aasm_event :save_as_draft do
    transitions :to => :draft, :from => :preview
  end
  aasm_event :publish do
    transitions :to => :published, :from => :preview
  end
  def set_initial_state
    #raise "entered set_initial_state"
    status = "preview"
  end
  ##########################################################
  ######## SCORING SYSTEM
  
  # moved to lib/cm_scores.rb - Luke
  
  ######## end SCORING SYSTEM
  ##########################################################
  
  
  def build_issues(hash)
    for issue_id in hash.values.uniq
      review_issue = ReviewIssue.new(:issue_id => issue_id, :review_id => id)
      review_issue.save
    end
  end
  
  
  
  private
  def protect_against_angry_abuse
    [self.class.find(:first, :conditions => ["user_id = ? and company_id = ? and created_at > ?", user, company, Time.now - 180.days])].compact.each do
      errors.add_to_base("You already submitted a review this company on this issue. You must wait at least 180 days between reviews.")
    end
  end
  

  
  
end
