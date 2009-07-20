class PeerRating < ActiveRecord::Base

  belongs_to :review
  belongs_to :user
  
  validates_presence_of :review, :user
  validates_associated :review, :user
  
  # The same user cannot rate for the same review more than once
  validates_uniqueness_of :review_id, :scope => :user_id
  
  validate_on_create :cant_vote_on_your_own_review
    
  VOTE_UP = 1
  VOTE_DOWN = -1

  private
    def cant_vote_on_your_own_review
      errors.add_to_base("You can't vote on your own reviews") if review.user == user
    end

end
