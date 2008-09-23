class ReviewsController < ResourceController::Base
  
  belongs_to :company
  
  def create
    
    @review = Review.new(:company_id => params[:company_id], :body => params[:review_presenter][:body])
    @review.review_issues.build(:issue_id => params[:review_presenter][:issue_id], :rating => params[:review_presenter][:rating])

    if @review.save
      redirect_to company_url(params[:company_id])
    else
      render :action => "new"
    end
  end
  
end