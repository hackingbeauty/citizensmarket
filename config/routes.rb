ActionController::Routing::Routes.draw do |map|

  map.connect '/issues/issue_picker', :controller => 'issues', :action => 'issue_picker'
  map.resources :issues

  map.connect '/users/update_issue_weights', :controller => 'issue_weights', :action => 'update'
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:id', :controller => 'users', :action => 'activate'
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password', :controller => 'users', :action => 'reset_password'

  map.resources :users,
                :member => {:issue_weights => :put}

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

  map.resource :home

  map.root :controller => "home", :action => "show"

end