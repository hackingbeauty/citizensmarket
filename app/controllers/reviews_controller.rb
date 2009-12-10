class ReviewsController < ApplicationController#ResourceController::Base
  
  #before_filter :login_required, :only => ['new', 'create', 'edit', 'update']
  #filter_access_to :all
  #belongs_to :company
  
  def index
    @reviews = Review.all
  end
  
  def show
    @review = Review.find(params[:id])
  end
  
  def new
    @review = Review.new
  end
  def create
    #raise "params = #{params.inspect}"
    @review = Review.new(params[:review])
    #raise "@review.company = #{@review.company}"
    @review.user = current_user
    if @review.save
      flash[:message] = "Review saved successfully."
      redirect_to(my_reviews_path) and return
    else 
      render(:action => "new") and return
    end
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      flash[:message] = (params[:review].has_key?(:aasm_event) ? "Your review has been successfully #{params[:review][:aasm_event]}ed" : "Saved successfully!")
      redirect_to review_url(@review)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_url
  end
  
  
  def issue_picker
    render :partial => 'issue_picker', :locals => {:issue => Issue.first}
  end
  
  # the routing to this function needs to be addressed by someone who knows more about routing than me
  # - Luke 2009-12-01
  def my_reviews
    @owner = current_user
    @reviews = Review.find(:all, :conditions => ["user_id = ?", @owner.id])
    render :action => "index"
  end
  
end