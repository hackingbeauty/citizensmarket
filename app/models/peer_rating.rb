class PeerRating < ActiveRecord::Base

  belongs_to :review
  belongs_to :user
  
  validates_presence_of :review, :user
  validates_associated :review, :user
  
  # The same user cannot rate for the same review more than once
  validates_uniqueness_of :review_id, :scope => :user_id
  
  
  VOTE_UP = 1
  VOTE_DOWN = 0

end
