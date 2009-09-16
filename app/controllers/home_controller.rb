class HomeController < ResourceController::Singleton
  actions :show, :dashboard
  
  def show
    return unless cookies[:auth_token]
    user = User.find_by_remember_token(cookies[:auth_token]) 
    if user  
       render :template => '/users/dashboard'
    end
  end
  
end