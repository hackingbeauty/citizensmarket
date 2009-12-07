module ReviewsHelper
  
  
  def setup_review(review)
    review.issues.build
    review
  end
  
end