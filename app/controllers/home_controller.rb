class HomeController < ResourceController::Singleton
  actions :show, :dashboard
  
  def show
    return unless cookies[:auth_token]
    user = User.find_by_remember_token(cookies[:auth_token]) 
    if user  
       render :template => '/users/dashboard'
    end
  end
  
  def search
    
    @companies = Company.search(params[:search][:q])
    
    @reviews = Review.search(params[:search][:q])
    #raise "@reviews.size = #{@reviews.size}"
  end
  
  
end