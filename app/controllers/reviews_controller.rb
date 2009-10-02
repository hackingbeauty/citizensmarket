class ReviewsController < ResourceController::Base
  
  before_filter :login_required, :only => ['new', 'create', 'edit', 'update']
  belongs_to :company
  
  def index
    @reviews = Review.find(:all)
  end
  
  def create
<<<<<<< HEAD:app/controllers/reviews_controller.rb
    company_id = params[:company_picker_id] || params[:company_id]
=======
    #raise "check params"
    #company_id = params[:company_picker_id] || params[:company_id]

>>>>>>> master_luke:app/controllers/reviews_controller.rb
    @review = Review.new(
      :company_id => params[:review_presenter][:company_id], 
      :body => params[:review_presenter][:body],  
      :rating => params[:review_presenter][:rating])
    @review.user = current_user
    if @review.save
      @review.build_issues(params[:issues])
      redirect_to company_url(@review.company_id)
    else
      render :action => "new"
    end
  end
  
  def update
    #raise "entered update and params = #{params.inspect}"
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      redirect_to review_url(@review)
    else
      render :action => 'edit'
    end
  end
  
end