ActionController::Routing::Routes.draw do |map|
              
  map.resources :companies, 
                :collection => 
                    { :suggestions => :get, 
                      :lookup => :get, 
                      :lookup_logo => :get } do |company|
    company.resources :reviews
  end
  
  map.resource :home
  
  map.root :controller => "home", :action => "show"

end
