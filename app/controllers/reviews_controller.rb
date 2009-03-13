class ReviewsController < ResourceController::Base
  
  before_filter :login_required, :only => ['new', 'create', 'edit', 'update']
  
  belongs_to :company
  
  def new
    if params[:company_id].nil?
      @review = Review.new
    else
      @review = Review.new(:company => Company.find(params[:company_id]))
    end
    
  end
  
  def create
    
    if params[:company_picker_id].nil?
      @review = Review.new(:company_id => params[:company_id], :body => params[:review_presenter][:body], :user_id => params[:review_presenter][:user_id], :rating => params[:review_presenter][:rating])
    else
      @review = Review.new(:company_id => params[:company_picker_id], :body => params[:review_presenter][:body], :user_id => params[:review_presenter][:user_id], :rating => params[:review_presenter][:rating])
    end
    
    if @review.save
      @review.build_issues(params[:issues])
      redirect_to company_url(params[:company_id])
    else
      raise "@review did not save, errors are: "+ @review.errors.full_messages.join(', ')
      render :action => "new"
    end
  end
  
end