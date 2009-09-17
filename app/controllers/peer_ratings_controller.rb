#class PeerRatingsController < ResourceController::Base
class PeerRatingsController < ApplicationController
  #belongs_to :review
  
  # Luke sez:  these routes are certainly not restful
  # Create PeerRatings by POSTing to
  # /reviews/:review_id/peer_ratings/vote_up
  # /reviews/:review_id/peer_ratings/vote_down
  
  
  # is intended to be accessed by ajax
  # should later be expanded to provide a redirect if .html is requested; a partial if .js is requested
  # i.e. to allow application to gracefully degrade if no javascript turned on for client
  def create
    peer_rating = PeerRating.new(params[:peer_rating])
    if peer_rating.save
      render :partial => 'feedback_given'
    else
      render :partial => 'feedback_failed'
    end
  end
  
  # old implementation.  This is only restful if mapped behind a restul routes.rb
  # I see no good reason to use this interface; will transition it out
  
  def vote_up
    old_create(PeerRating::VOTE_UP)
    render :partial => 'reviews/feedback_given'
  end
  
  def vote_down
    old_create(PeerRating::VOTE_DOWN)
    render :partial => 'reviews/feedback_given'
  end
  
  
  private
  def old_create(score)
    return if !Review.find(params[:review_id])
    PeerRating.new do |pr|
      pr.review_id = review.id
      pr.user_id = current_user.id
      pr.score = score
    end.save!
  end
  
end
