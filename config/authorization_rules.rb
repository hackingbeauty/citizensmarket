authorization do
  
  role :guest do
    
    has_permission_on :reviews, :to => :read do
      if_attribute :status => "published"
    end
    has_permission_on :companies, :to => :read
    has_permission_on :peer_ratings, :to => :read
    
    has_permission_on :users, :to => :create
    
  end
  
  role :user do
    includes :guest
    
    has_permission_on :reviews, :to => :create
    has_permission_on :reviews, :to => [:edit, :update, :destroy], :join_by => :and do
      if_attribute :user => is {user}
      if_attribute :status => is_not {"published"}
    end
    
    has_permission_on :users, :to => :manage do
      if_attribute :id => is {user.id}
    end
    
    has_permission_on :peer_ratings, :to => :create
    
  end
  
  role :admin do
    includes :guest
    includes :user
    
    has_permission_on [:reviews, :companies, :issues, :users], :to => :manage
    
  end
  
  
  privileges do
    privilege :manage, :includes => [:create, :read, :update, :delete]
    privilege :read, :includes => [:index, :show]
    privilege :create, :includes => :new
    privilege :update, :includes => :edit
    privilege :delete, :includes => :destroy
  end
  
  
end