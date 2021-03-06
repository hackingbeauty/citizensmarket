ActionController::Routing::Routes.draw do |map|
  map.resources :sources

  
  
  map.my_profile '/my_profile', :controller => "users", :action => "my_profile"
  
  map.connect '/issues/issue_picker', :controller => 'issues', :action => 'issue_picker'
  map.resources :issues

  map.my_reviews '/my_reviews', :controller => 'reviews', :action => 'my_reviews'
  map.search '/search', :controller => 'home', :action => 'search'
  map.connect '/users/update_issue_weights', :controller => 'issue_weights', :action => 'update'
  map.compare '/compare', :controller => 'companies', :action => 'compare'
  map.add '/add', :controller => 'companies', :action => 'new'
  map.rate '/rate', :controller => 'reviews', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.session '/session', :controller => 'sessions', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:id', :controller => 'users', :action => 'activate'
  map.home '/home', :controller => 'home', :action => 'show'
  map.change_password '/change_password', :controller => 'users', :action => 'change_password'
  map.update_password '/update_password', :controller => 'users', :action => 'update_password'
  map.forgot '/forgot', :controller => 'users', :action => 'forgot'
  map.reset 'reset/:reset_code', :controller => 'users', :action => 'reset'

  map.resources :users, :member => {:issue_weights => :put} do |user|
    user.resources :reviews
  end
    
  map.dashboard "/dashboard", :controller => "users", :action => "dashboard"

  map.resource :session

  map.connect '/companies/company_picker', :controller => 'companies', :action => 'company_picker'
  map.resources :companies,
                :collection =>
                    { :suggestions => :get,
                      :lookup => :get,
                      :lookup_logo => :get } do |company|
    company.resources :reviews
  end
  
  map.connect "reviews/issue_picker", :controller => "reviews", :action => 'issue_picker'
  map.publish_review "reviews/:id/publish", :controller => "reviews", :action => "update", :review => {:aasm_event => "publish"}
  #map.publish_review(:review) "reviews/:id/publish", :controller => "reviews", :action => "update", :aasm_event => "publish"
  map.resources :reviews do |review|
    review.resources :peer_ratings,
                     :collection => { :vote_up => :post, :vote_down => :post }
  end
  
  # map.connect '/edit', :controller => 'companies', :action => 'edit'
  
  map.connect '/browse', :controller => 'companies', :action => 'index'
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