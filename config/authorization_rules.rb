# this helps me think:
# Users can write reviews, then publish them.
# Users can leave peer ratings on others' reviews

# Admins can add / edit companies
# Admins can add / edit issues

authorization do
  
  role :guest do
    
    has_permission_on :reviews, :to => :read do
      if_attribute :status => "published"
    end
    has_permission_on :companies, :to => [:index, :show, :company_picker]
    has_permission_on :peer_ratings, :to => :read
    
    has_permission_on :users, :to => :create
    
    has_permission_on :issues, :to => [:index, :show]
    
  end
  
  role :contributor do
    includes :guest
    
    has_permission_on :reviews, :to => :create
    has_permission_on :reviews, :to => [:edit, :update, :destroy], :join_by => :and do
      if_attribute :user => is {user}
      if_attribute :status => is_not {"published"}
    end
    
    has_permission_on :users, :to => :manage do
      if_attribute :id => is {user.id}
    end
    
    has_permission_on :peer_ratings, :to => :create #do
    #  if_attribute :review => {:user => {:id => is_not {user.id}}}
      # or should this be handled by validation? (i.e. to allow custom error messages)
    #end
    
  end
  
  role :admin do
    
    includes :guest
    includes :contributor
    
    has_permission_on [:reviews, :companies, :issues, :users], :to => [:new, :create, :edit, :update, :destroy]
    
  end
  
  
  #privileges do
  #  privilege :read, :includes => [:index, :show]
  #  
  #end
  
  
end