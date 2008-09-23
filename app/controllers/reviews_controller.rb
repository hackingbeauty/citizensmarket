class ReviewsController < ResourceController::Base
  
  belongs_to :company
  #model_name :review_presenter
  
  new_action.before do
    2.times {@review.review_issues.build}
  end
  
  def create
    render :text => params.inspect
  end
  
end
