class ReviewsController < ResourceController::Base
  
  belongs_to :company
  #model_name :review_presenter
  
  def create
    render :text => params.inspect
  end
  
end
