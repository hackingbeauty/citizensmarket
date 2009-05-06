ActionController::Routing::Routes.draw do |map|

  map.connect '/issues/issue_picker', :controller => 'issues', :action => 'issue_picker'
  map.resources :issues


  map.connect '/users/update_issue_weights', :controller => 'issue_weights', :action => 'update'
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:id', :controller => 'users', :action => 'activate'
  map.change_password '/change_password', :controller => 'users', :action => 'change_password'
  map.update_password '/update_password', :controller => 'users', :action => 'update_password'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password', :controller => 'users', :action => 'reset_password'


  map.resources :users, 
    :member => {
      :issue_weights => :put
    }

  map.resource :session

  map.connect '/companies/company_picker', :controller => 'companies', :action => 'company_picker'
  map.resources :companies,
                :collection =>
                    { :suggestions => :get,
                      :lookup => :get,
                      :lookup_logo => :get } do |company|
    company.resources :reviews
  end
  
  map.resources :reviews do |review|
    review.resources :peer_ratings,
                     :collection => { :vote_up => :post, :vote_down => :post }
  end
  
  # map.connect '/edit', :controller => 'companies', :action => 'edit'
  
  map.connect '/admin', :controller => 'companies', :action => 'administer'
  map.connect '/score', :controller => 'companies', :action => 'find_score'
  map.connect '/about', :controller => 'about', :action => 'team'
  map.connect '/terms', :controller => 'home', :action => 'terms'
  map.connect '/attribution', :controller => 'home', :action => 'attribution'
  map.connect '/privacy', :controller => 'home', :action => 'privacy'
  map.connect '/dmca', :controller => 'home', :action => 'dmca'
  map.connect '/contact', :controller => 'home', :action => 'contact'
  map.connect '/take_action', :controller => 'home', :action => 'take_action'
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.resource :home

  map.root :controller => "home", :action => "show"

end